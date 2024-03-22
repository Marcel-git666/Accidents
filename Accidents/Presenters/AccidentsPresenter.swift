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
    @Published var accidentLocation: AccidentLocation = AccidentLocation( // Empty accidentLocation
        date: Date(),
        city: "",
        street: "",
        houseNumber: "",
        kilometerReading: 0.0
    )
    @Published var accidentDriver1: Driver = Driver(name: "Johny", address: "", phoneNumber: "", driverLicenseNumber: "", vehicleRegistrationPlate: "", insuranceCompany: "", insurancePolicyNumber: "")
    @Published var accidentDriver2: Driver = Driver(name: "Cash", address: "", phoneNumber: "", driverLicenseNumber: "", vehicleRegistrationPlate: "", insuranceCompany: "", insurancePolicyNumber: "")
    
    @Published var accidentDescription: AccidentDescription = AccidentDescription(accidentDescription: "dummy description", vehicleDamage: "no damage")
    @Published var errorMessage: String? = nil
    
    @Published var viewState: AccidentReportFillingState = .accidentList
    
    
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
    
    func goNext() {
        switch viewState {
        case .accidentList:
            viewState = .location
        case .location:
            viewState = .driver1
        case .driver1:
            viewState = .driver2
        case .driver2:
            viewState = .accidentList
        case .description:
            viewState = .accidentList
        }
    }
    
    func createReportAndSave() {
        let report = AccidentReport(id: UUID(), accidentLocation: accidentLocation, driver: accidentDriver1, otherDriver: accidentDriver2, accidentDescription: accidentDescription)
        saveReport(report)
    }
    
    func saveReport(_ report: AccidentReport) {
        Task {
            
            do {
                try await repository.save(report)
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
                self.accidentReports.removeAll { $0.id == report.id }
            } catch let error as CoreDataError {
                errorMessage = error.rawValue
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
