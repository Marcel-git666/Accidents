//
//  AccidentsCoordinator.swift
//  Accidents
//

import SwiftUI

// MARK: - Protocol

@MainActor
protocol AccidentsCoordinating: AnyObject, Observable {
    var viewState: AccidentReportNavigationState { get set }
    var selectedTab: AccidentReportFillingState { get set }
    var accidentReports: [AccidentReport] { get }
    var errorMessage: String? { get }
    var reportToPreview: AccidentReport? { get set }

    var locationForm: LocationFormModel { get }
    var driverAForm: DriverFormModel { get }
    var driverBForm: DriverFormModel { get }
    var descriptionForm: DescriptionFormModel { get }
    var impactAForm: ImpactFormModel { get }
    var impactBForm: ImpactFormModel { get }
    var situationForm: SituationFormModel { get }

    func goNext()
    func goBack()
    func handleSelectedTab(_ tab: AccidentReportFillingState)
    func editReport(_ report: AccidentReport)
    func exitAndSaveReport()
    func removeReport(_ report: AccidentReport)
    func fetchAccidents() async
    func exportPDF(for report: AccidentReport)
    func showReportPreview(for report: AccidentReport)
    func closeReportPreview()
}

// MARK: - Implementation

@MainActor
@Observable
class AccidentsCoordinator: AccidentsCoordinating {
    private let repository: AccidentReportRepository

    // Navigation
    var viewState: AccidentReportNavigationState = .accidentList
    var selectedTab: AccidentReportFillingState = .location
    @ObservationIgnored var transitionEffect: AnyTransition = .scale

    // Report list
    var accidentReports: [AccidentReport] = []
    var selectedAccident: AccidentReport?
    var errorMessage: String?
    var reportToPreview: AccidentReport?

    // Form models
    let locationForm = LocationFormModel()
    let driverAForm = DriverFormModel()
    let driverBForm = DriverFormModel()
    let descriptionForm = DescriptionFormModel()
    let impactAForm = ImpactFormModel()
    let impactBForm = ImpactFormModel()
    let situationForm = SituationFormModel()

    init(repository: AccidentReportRepository) {
        self.repository = repository
        setUp()
    }

    private func setUp() {
        Task { await fetchAccidents() }
    }

    func fetchAccidents() async {
        do {
            accidentReports = try await repository.fetchAll()
        } catch let error as CoreDataError {
            errorMessage = error.rawValue
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func handleSelectedTab(_ tab: AccidentReportFillingState) {
        withAnimation { selectedTab = tab }
    }

    func goNext() {
        withAnimation {
            switch viewState {
            case .accidentList:
                selectedTab = .location
                viewState = .start
                resetForm()
            case .start:
                switch selectedTab {
                case .location:     selectedTab = .driver1
                case .driver1:      selectedTab = .driver2
                case .driver2:      selectedTab = .description
                case .description:  selectedTab = .pointOfImpact1
                case .pointOfImpact1: selectedTab = .pointOfImpact2
                case .pointOfImpact2: selectedTab = .mapView
                case .mapView:      selectedTab = .location
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
                case .location:       selectedTab = .mapView
                case .driver1:        selectedTab = .location
                case .driver2:        selectedTab = .driver1
                case .description:    selectedTab = .driver2
                case .pointOfImpact1: selectedTab = .description
                case .pointOfImpact2: selectedTab = .pointOfImpact1
                case .mapView:        selectedTab = .pointOfImpact2
                }
            }
        }
    }

    func exitAndSaveReport() {
        createReportAndSave()
    }

    func createReportAndSave() {
        let report = AccidentReport(
            id: selectedAccident?.id ?? UUID(),
            accidentLocation: locationForm.location,
            driver: driverAForm.driver,
            otherDriver: driverBForm.driver,
            accidentDescription: descriptionForm.accidentDescription,
            pointOfImpact1: impactAForm.pointOfImpact,
            pointOfImpact2: impactBForm.pointOfImpact,
            accidentSituation: situationForm.accidentSituation
        )

        if let selectedAccident {
            Task {
                if let index = accidentReports.firstIndex(where: { $0.id == report.id }) {
                    accidentReports[index] = report
                } else {
                    print("Report with ID \(report.id) not found")
                }
                await updateReportAndSave(report: report)
            }
            self.selectedAccident = nil
        } else {
            saveReport(report)
        }
        viewState = .accidentList
    }

    func saveReport(_ report: AccidentReport) {
        Task {
            do {
                try await repository.saveReport(report)
                errorMessage = nil
                accidentReports.append(report)
            } catch let error as CoreDataError {
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
                accidentReports.removeAll { $0.id == report.id }
            } catch let error as CoreDataError {
                errorMessage = error.rawValue
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func editReport(_ report: AccidentReport) {
        selectedAccident = report
        locationForm.location = report.accidentLocation
        driverAForm.driver = report.driver ?? PreviewData.driverA
        driverBForm.driver = report.otherDriver ?? PreviewData.driverB
        descriptionForm.accidentDescription = report.accidentDescription
        impactAForm.load(report.pointOfImpact1 ?? .defaultValue)
        impactBForm.load(report.pointOfImpact2 ?? .defaultValue)
        let situation = report.accidentSituation ?? AccidentSituation(roadShape: .crossroad)
        situationForm.load(from: situation)
        withAnimation {
            selectedTab = .location
            viewState = .start
        }
    }

    func exportPDF(for report: AccidentReport) {
        guard let url = PDFManager.shared.renderPDF(with: report, templateImageName: "form") else {
            print("Failed to generate PDF.")
            return
        }
        PDFManager.shared.sharePDF(url)
    }

    func showReportPreview(for report: AccidentReport) {
        reportToPreview = report
    }

    func closeReportPreview() {
        reportToPreview = nil
    }

    // MARK: - Private

    private func resetForm() {
        locationForm.location = .defaultValue
        driverAForm.driver = PreviewData.driverA
        driverBForm.driver = PreviewData.driverA
        descriptionForm.accidentDescription = .defaultValue
        impactAForm.reset()
        impactBForm.reset()
        situationForm.reset()
    }

    private func updateReportAndSave(report: AccidentReport) async {
        do {
            try await repository.updateReport(report)
            errorMessage = nil
            await fetchAccidents()
        } catch let error as CoreDataError {
            errorMessage = error.rawValue
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
