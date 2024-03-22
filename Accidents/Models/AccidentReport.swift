//
//  Accident.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentReport: Identifiable, Hashable, Codable {
        
    let id: UUID
    var accidentLocation: AccidentLocation
    var driver: Driver
    var otherDriver: Driver?
//    var witnesses: [Witness]?
    var accidentDescription: AccidentDescription
//    var sketch: UIImage?
//    var driverSignature: Data?
//    var otherDriverSignature: Data?
    
    init(id: UUID, accidentLocation: AccidentLocation, driver: Driver, otherDriver: Driver, accidentDescription: AccidentDescription) {
        self.id = id
        self.accidentLocation = accidentLocation
        self.accidentDescription = accidentDescription
        self.driver = driver
        self.otherDriver = otherDriver
    }
    
    static func == (lhs: AccidentReport, rhs: AccidentReport) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static var sampleData: AccidentReport {
        let date = Date()

        let sampleAccidentReport = AccidentReport(
            id: UUID(),
            accidentLocation: AccidentLocation(
                date: date,
                city: "Prague",
                street: "Wenceslas Square",
                houseNumber: "1a"
            ), driver: Driver(
                name: "John Doe",
                address: "123 Main Street",
                phoneNumber: "12313245646",
                driverLicenseNumber: "456456",
                vehicleRegistrationPlate: "5464645",
                insuranceCompany: "Kooperativa",
                insurancePolicyNumber: "aswerwedf"
            ), otherDriver: Driver(
                name: "Maverick",
                address: "555 Main Street",
                phoneNumber: "999999999",
                driverLicenseNumber: "4wedf456",
                vehicleRegistrationPlate: "fw645",
                insuranceCompany: "Kooperativa",
                insurancePolicyNumber: "as44564556wedf"
            ),
            accidentDescription: AccidentDescription(
                accidentDescription: "Minor collision at an intersection",
                vehicleDamage: "Scratches on the bumper"
            )
        )

        return sampleAccidentReport
    }
}

struct AccidentLocation: Codable {
    var date: Date
    var city: String
    var street: String
    var houseNumber: String
    var kilometerReading: Double?
    var injuries: Bool?
}

struct AccidentDescription: Codable {
    var accidentDescription: String
    var vehicleDamage: String
}

struct Driver: Codable {
    var name: String
    var address: String
    var phoneNumber: String
    var driverLicenseNumber: String
    var vehicleRegistrationPlate: String
    var insuranceCompany: String
    var insurancePolicyNumber: String
    var isAtFault: Bool?
}

//struct Witness: Codable {
//    var name: String
//    var address: String
//    var phoneNumber: String
//}

enum DriverType {
  case driver1
  case driver2
}
