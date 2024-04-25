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
    var accidentDescription: AccidentDescription
    var pointOfImpact1: PointOfImpact?
    var pointOfImpact2: PointOfImpact?
    var accidentSituation: AccidentSituation?
        
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
                date: date, city: "Prague", street: "Wenceslas Square", houseNumber: "1a", kilometerReading: "0", injuries: false, 
                witnesses: [Witness.sample], otherDamage: false, policeInvolved: true
            ), driver: Driver.sample1,
            otherDriver: Driver.sample2,
            accidentDescription: AccidentDescription(notes1: "", notes2: "", vehicleDamage1: Array(repeating: false, count: 17), 
                                                     vehicleDamage2: Array(repeating: false, count: 17)),
            pointOfImpact1: nil,
            pointOfImpact2: nil,
            accidentSituation: AccidentSituation(roadShape: .crossroad)
        )

        return sampleAccidentReport
    }
}

struct AccidentLocation: Codable {
    var date: Date
    var city: String
    var street: String
    var houseNumber: String
    var kilometerReading: String
    var injuries: Bool
    var witnesses: [Witness]
    var otherDamage: Bool
    var policeInvolved: Bool
}

struct AccidentDescription: Codable {
    var notes1: String
    var notes2: String
    var vehicleDamage1: [Bool]
    var vehicleDamage2: [Bool]
}

struct Driver: Codable {
    var insuredName: String
    var insuredAddress: String
    var insuredPhone: String
    var insuredPayerOfVAT: Bool
    var vehicleManufacturerAndType: String
    var vehicleYearOfManufacture: String
    var vehicleStateRegistrationPlate: String
    var insurer: String
    var insurerBranchAddress: String
    var insuranceNumber: String
    var greenCardNumber: String
    var borderInsuranceValidUntil: Date
    var comprehensiveInsurance: Bool
    var comprehensiveInsuranceCompany: String
    var surnameOfDriver: String
    var firstNameOfDriver: String
    var addressOfDriver: String
    var phoneNumberOfDriver: String
    var driverLicenseNumber: String
    var categoryOfLicense: String
    var licenseIssuedBy: String
    
    static let sample1 = Driver(insuredName: "CEZ a.s.", insuredAddress: "Somehwhere in bushes", insuredPhone: "12345644", 
                                insuredPayerOfVAT: true, vehicleManufacturerAndType: "Mercedes Benz ML", vehicleYearOfManufacture: "2010",
                                vehicleStateRegistrationPlate: "JUDO1", insurer: "Kooperativa a.s.", insurerBranchAddress: "somewhere in Prague",
                                insuranceNumber: "12311122AA", greenCardNumber: "1232155", borderInsuranceValidUntil: Date.now,
                                comprehensiveInsurance: true, comprehensiveInsuranceCompany: "Allianz Pojistovna a.s.",
                                surnameOfDriver: "Z depa", firstNameOfDriver: "Pepa", addressOfDriver: "Krnov", phoneNumberOfDriver: "1231223",
                                driverLicenseNumber: "unknown", categoryOfLicense: "AM2", licenseIssuedBy: "Magistrat mesta Olomouce")
    static let sample2 = Driver(insuredName: "CEZ a.s.", insuredAddress: "Somehwhere in bushes", insuredPhone: "12345644", 
                                insuredPayerOfVAT: true, vehicleManufacturerAndType: "Wartburg", vehicleYearOfManufacture: "1988",
                                vehicleStateRegistrationPlate: "POPELNICE", insurer: "Kooperativa a.s.", insurerBranchAddress: "somewhere in Prague", 
                                insuranceNumber: "12311122AA", greenCardNumber: "1232155", borderInsuranceValidUntil: Date.now,
                                comprehensiveInsurance: true, comprehensiveInsuranceCompany: "Allianz Pojistovna a.s.", 
                                surnameOfDriver: "Z Ase", firstNameOfDriver: "Franta", addressOfDriver: "As",
                                phoneNumberOfDriver: "1231223", driverLicenseNumber: "unknown", categoryOfLicense: "AM2",
                                licenseIssuedBy: "Magistrat mesta Karlovy Vary")
}

struct Witness: Codable, Hashable {
    var name: String
    var address: String
    var phoneNumber: String
    
    static let sample = Witness(name: "Rabi Lowe", address: "Poland", phoneNumber: "456789456")
}

struct PointOfImpact: Codable {
    var crashPoint: CGPoint
    var arrowRotation: Double
    var scale: CGFloat
}

struct AccidentSituation: Codable {
    var roadShape: RoadShapeSelector
    var blueVehicle: Vehicle?
    var yellowVehicle: Vehicle?
    var otherVehicles: [Vehicle] = []
}
