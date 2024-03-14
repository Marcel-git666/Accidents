//
//  AccidentsPresenter.swift
//  Accidents
//
//  Created by Marcel Mravec on 14.03.2024.
//

import SwiftUI

class AccidentsPresenter: ObservableObject {
    
    @Published var accidentReports: [AccidentReport] = []
    @Published var accidentLocation: AccidentLocation = AccidentLocation( // Empty accidentLocation
        date: Date(),
        city: "",
        street: "",
        houseNumber: "",
        kilometerReading: 0.0
    )
    @Published var accidentDriver: Driver = Driver(name: "John", address: "", phoneNumber: "", driverLicenseNumber: "", vehicleRegistrationPlate: "", insuranceCompany: "", insurancePolicyNumber: "")
    @Published var accidentDescription: AccidentDescription = AccidentDescription(description: "dummy description", vehicleDamage: "no damage")
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
        
    }
    
    func saveLocation() {
        print("Saving location where it is needed....")
    }
    
    func saveReport() {
        let report = AccidentReport(driver: accidentDriver, accidentLocation: accidentLocation, accidentDescription: accidentDescription)
        accidentReports.append(report)
    }
    
}
