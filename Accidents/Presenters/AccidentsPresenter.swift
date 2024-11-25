//
//  AccidentsPresenter.swift
//  Accidents
//
//  Created by Marcel Mravec on 14.03.2024.
//

import SwiftUI

@MainActor
class AccidentsPresenter: ObservableObject {
    private let repository: AccidentReportRepository
    
    @Published var accidentReports: [AccidentReport] = []
    @Published var accidentLocation: AccidentLocation = AccidentLocation(
        date: Date(),
        city: "",
        street: "",
        houseNumber: "",
        kilometerReading: "0.0",
        injuries: false,
        witnesses: [],
        otherDamage: false,
        policeInvolved: false
    )
    @Published var accidentDriver1: Driver = Driver.sample1
    @Published var accidentDriver2: Driver = Driver.sample2
    
    @Published var accidentDescription: AccidentDescription =
    AccidentDescription(notes1: "notes 1", notes2: "notes 2",
                        vehicleDamage1: Array(repeating: false, count: 17),
                        vehicleDamage2: Array(repeating: false, count: 17))
    @Published var errorMessage: String?
    @Published var selectedAccident: AccidentReport?
    @Published var viewState: AccidentReportNavigationState = .accidentList
    @Published var selectedTab: AccidentReportFillingState = .location
    @Published var pointOfImpact1: PointOfImpact = PointOfImpact(crashPoint: CGPoint(x: 200, y: 100), arrowRotation: 0, scale: 1)
    @Published var pointOfImpact2: PointOfImpact = PointOfImpact(crashPoint: CGPoint(x: 200, y: 100), arrowRotation: 0, scale: 1)
    @Published var accidentSituation: AccidentSituation = AccidentSituation(roadShape: .crossroad)
    @Published var transitionEffect: AnyTransition = .scale
    
    init(repository: AccidentReportRepository) {
        self.repository = repository
        setUp()
    }
    
    func setUp() {
        Task {
            await self.fetchAccidents()
        }
    }
    
    func fetchAccidents() async {
        
        do {
            let fetchedReports = try await repository.fetchAll()
            DispatchQueue.main.async {
                self.accidentReports = fetchedReports
            }
        } catch let error as CoreDataError {
            errorMessage = error.rawValue
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
    
    func handleSelectedTab(_ tab: AccidentReportFillingState) {
        withAnimation {
            selectedTab = tab
        }
    }
    
    func goNext() {
        withAnimation {
            switch viewState {
            case .accidentList:
                selectedTab = .location
                viewState = .start
            case .start:
                switch selectedTab {
                case .location:
                    selectedTab = .driver1
                case .driver1:
                    selectedTab = .driver2
                case .driver2:
                    selectedTab = .description
                case .description:
                    selectedTab = .pointOfImpact1
                case .pointOfImpact1:
                    selectedTab = .pointOfImpact2
                case .pointOfImpact2:
                    selectedTab = .mapView
                case .mapView:
                    selectedTab = .location
                }
            }
        }
    }
    
    func goBack() {
        withAnimation {
            switch viewState {
            case .accidentList:
                selectedTab = .location
                viewState = .start
            case .start:
                switch selectedTab {
                case .location:
                    selectedTab = .mapView
                case .driver1:
                    selectedTab = .location
                case .driver2:
                    selectedTab = .driver1
                case .description:
                    selectedTab = .driver2
                case .pointOfImpact1:
                    selectedTab = .description
                case .pointOfImpact2:
                    selectedTab = .pointOfImpact1
                case .mapView:
                    selectedTab = .pointOfImpact2
                }
            }
        }
    }
    
    func createReportAndSave() {
        if let selectedAccident = selectedAccident {
            Task {
                let report = AccidentReport(id: selectedAccident.id, accidentLocation: accidentLocation,
                                            driver: accidentDriver1, otherDriver: accidentDriver2, accidentDescription: accidentDescription,
                                            pointOfImpact1: pointOfImpact1, pointOfImpact2: pointOfImpact2, accidentSituation: accidentSituation)
                if let index = accidentReports.firstIndex(where: { $0.id == report.id }) {
                    self.accidentReports[index] = report
                } else {
                    // The report with the specified ID was not found in the array
                    print("Report with ID \(report) not found")
                }
                await updateReportAndSave(report: report)
            }
            self.selectedAccident = nil
            viewState = .accidentList
            return
        }
        
        let report = AccidentReport(id: UUID(), accidentLocation: accidentLocation,
                                    driver: accidentDriver1, otherDriver: accidentDriver2,
                                    accidentDescription: accidentDescription, pointOfImpact1: pointOfImpact1,
                                    pointOfImpact2: pointOfImpact2, accidentSituation: accidentSituation)
        saveReport(report)
        viewState = .accidentList
        
    }
    
    func saveVehiclesToAccidentSituation(blueVehicle: Vehicle?, yellowVehicle: Vehicle?, otherVehicles: [Vehicle]) {
        
        // Update AccidentSituation
        accidentSituation.blueVehicle = blueVehicle
        accidentSituation.yellowVehicle = yellowVehicle
        accidentSituation.otherVehicles = otherVehicles
    }
    
    func saveReport(_ report: AccidentReport) {
        Task {
            
            do {
                try await repository.saveReport(report)
                errorMessage = nil
                accidentReports.append(report)
            } catch let error as CoreDataError {
                print(error.localizedDescription)
                errorMessage = error.rawValue
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func removeReport(_ report: AccidentReport) {
        Task {
            do {
                try await repository.removeReport(report)
                self.accidentReports.removeAll { $0.id == report.id }
            } catch let error as CoreDataError {
                errorMessage = error.rawValue
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func editReport(_ report: AccidentReport) {
        selectedAccident = report
        accidentLocation = report.accidentLocation
        accidentDriver1 = report.driver
        accidentDriver2 = report.otherDriver!
        accidentDescription = report.accidentDescription
        pointOfImpact1 = report.pointOfImpact1 ?? PointOfImpact(crashPoint: CGPoint(x: 50, y: 100), arrowRotation: 0, scale: 1)
        pointOfImpact2 = report.pointOfImpact2 ?? PointOfImpact(crashPoint: CGPoint(x: 50, y: 100), arrowRotation: 0, scale: 1)
        accidentSituation = report.accidentSituation ?? AccidentSituation(roadShape: .crossroad)
        goNext()
    }
    
    func updateReportAndSave(report: AccidentReport) async {
        do {
            try await repository.updateReport(report)
            errorMessage = nil
            await fetchAccidents()
            
        } catch {
            // Handle errors more specifically
            if let coreDataError = error as? CoreDataError {
                errorMessage = coreDataError.rawValue
            } else {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func generatePDF(for report: AccidentReport) -> URL? {
        PDFManager.shared.renderPDF(
            with: report,
            templateImageName: "form"
        )
    }
    
    func exportPDF(for report: AccidentReport) {
        guard let pdfURL = generatePDF(for: report) else {
            print("Failed to generate PDF.")
            return
        }
        
        PDFManager.shared.sharePDF(pdfURL)
    }
    
    private func getTemplateImageName() -> String? {
        // Ensure the image is available in the bundle
        let imageName = "form" // Change this if your PNG file has a different name
        if UIImage(named: imageName) != nil {
            return imageName
        } else {
            print("Template image '\(imageName)' not found in the bundle.")
            return nil
        }
    }
}
