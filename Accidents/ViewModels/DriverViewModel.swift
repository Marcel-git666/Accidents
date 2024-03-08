//
//  DriverViewModel.swift
//  Accidents
//
//  Created by Marcel Mravec on 06.03.2024.
//

import SwiftUI

protocol DriverViewModelProtocol: ObservableObject {
    typealias SaveDriverCallback = (Driver) -> Void
    var accidentDriver: Driver { get set }
    func saveDriver(driverType: DriverType, callback: @escaping SaveDriverCallback)
}

class DriverViewModel: DriverViewModelProtocol {
    @Published var accidentDriver: Driver = Driver(name: "John", address: "", phoneNumber: "", driverLicenseNumber: "", vehicleRegistrationPlate: "", insuranceCompany: "", insurancePolicyNumber: "")
    private let driverDataService: DriverDataServiceProtocol
    
    init(driverDataService: DriverDataServiceProtocol) {
        self.driverDataService = driverDataService
    }
    
    func saveDriver(driverType: DriverType, callback: @escaping DriverViewModelProtocol.SaveDriverCallback) {
        driverDataService.saveDriver(accidentDriver, callback: callback)
    }
}
