//
//  AccidentsPresenter.swift
//  Accidents
//
//  Created by Marcel Mravec on 14.03.2024.
//

import SwiftUI

//protocol AccidentsPresenterProtocol: ObservableObject {
//  var accidentReports: [AccidentReport] { get set }
//  func fetchAccidents()
//  func saveLocation() // ...
//  func saveReport() // ...
//}

class AccidentsPresenter: ObservableObject {
    private let repository: AccidentReportRepository
    
    init(repository: AccidentReportRepository) {
        self.repository = repository
    }
    
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
    private var _viewState: AccidentReportFillingState = .accidentList
    
    var viewState: AccidentReportFillingState {
        get {
            return _viewState
        }
        set {
            // Update state only if it's different
            if _viewState != newValue {
                _viewState = newValue
                objectWillChange.send() // Notify observers
            }
        }
    }
    
    func fetchAccidents() {
        repository.fetchAll { reports, error in
            if let error = error {
                // Handle fetching errors
            } else {
                self.accidentReports = reports
            }
        }
    }
    
    func saveLocation() {
        print("Saving location where it is needed....")
    }
    
    func saveReport() {
      let report = AccidentReport(accidentLocation: accidentLocation, driver: accidentDriver1, otherDriver: accidentDriver2, accidentDescription: accidentDescription)
      repository.save(report) { [weak self] error in
        if let error {
          print(error.localizedDescription)
        } else {
          // Update your list of reports here
          self?.accidentReports.append(report)
        }
      }
    }
    
}
