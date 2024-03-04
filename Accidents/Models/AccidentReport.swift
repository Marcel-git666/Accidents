//
//  Accident.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentReport: Identifiable {
    let id: UUID
    var accidentLocation: AccidentLocation
    var driver: Driver
    var otherDriver: Driver?
    var witnesses: [Witness]?
    var accidentDescription: AccidentDescription
    var sketch: UIImage?
    var driverSignature: Data?
    var otherDriverSignature: Data?
    
    init(driver: Driver, accidentLocation: AccidentLocation, accidentDescription: AccidentDescription) {
        self.id = UUID()
        self.accidentLocation = accidentLocation
        self.accidentDescription = accidentDescription
        self.driver = driver
    }
    static var sampleData: AccidentReport {
        let date = Date()
        let timeInterval = date.timeIntervalSince1970

        let sampleAccidentReport = AccidentReport(
            driver: Driver(
                name: "John Doe",
                address: "123 Main Street",
                phoneNumber: "12313245646",
                driverLicenseNumber: "456456",
                vehicleRegistrationPlate: "5464645",
                insuranceCompany: "Kooperativa",
                insurancePolicyNumber: "aswerwedf"
            ),
            accidentLocation: AccidentLocation(
                date: date,
                time: timeInterval,
                city: "Prague",
                street: "Wenceslas Square"
            ),
            accidentDescription: AccidentDescription(
                description: "Minor collision at an intersection",
                vehicleDamage: "Scratches on the bumper"
            )
        )

        return sampleAccidentReport
    }
}

struct AccidentLocation {
  var date: Date
  var time: TimeInterval
  var city: String
  var street: String
  var houseNumber: String?
  var kilometerReading: Double?
}

struct AccidentDescription {
    var description: String
    var vehicleDamage: String
    var injuries: String?
}

struct Driver {
    var name: String
    var address: String
    var phoneNumber: String
    var driverLicenseNumber: String
    var vehicleRegistrationPlate: String
    var insuranceCompany: String
    var insurancePolicyNumber: String
}

struct Witness {
    var name: String
    var address: String
    var phoneNumber: String
}
