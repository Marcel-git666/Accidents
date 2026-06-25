//
//  PreviewData.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.06.2026.
//

import Foundation

enum PreviewData {
    
    @MainActor static let driverA = Driver(
        insuredName: "Česká podnikatelská pojišťovna a.s.",
        insuredAddress: "Brno, Pekařská 58, 60200",
        insuredPhone: "12345644",
        insuredPayerOfVAT: true,
        vehicleManufacturerAndType: "Mercedes Benz ML",
        vehicleYearOfManufacture: "2010", vehicleStateRegistrationPlate: "JUDO1",
        insurer: "Kooperativa a.s.",
        insurerBranchAddress: "somewhere in Prague",
        insuranceNumber: "12311122AA",
        greenCardNumber: "1232155",
        borderInsuranceValidUntil: Date.now,
        comprehensiveInsurance: true,
        comprehensiveInsuranceCompany:
                                    "Allianz Pojistovna a.s.",
        surnameOfDriver: "Z depa",
        firstNameOfDriver: "Pepa",
        addressOfDriver: "Krnov",
        phoneNumberOfDriver: "1231223",
        driverLicenseNumber: "unknown",
        categoryOfLicense: "AM2",
        licenseIssuedBy: "Magistrat mesta Olomouce"
    )
    
    @MainActor static let driverB = Driver(
        insuredName: "Kooperativa a.s.",
        insuredAddress: "Praha, Kolbenova 9",
        insuredPhone: "123456449",
        insuredPayerOfVAT: true,
        vehicleManufacturerAndType: "Wartburg",
        vehicleYearOfManufacture: "1988",
        vehicleStateRegistrationPlate: "POPELNICE",
        insurer: "Kooperativa a.s.",
        insurerBranchAddress: "somewhere in Prague",
        insuranceNumber: "12311122AA",
        greenCardNumber: "1232155",
        borderInsuranceValidUntil: Date.now,
        comprehensiveInsurance: true,
        comprehensiveInsuranceCompany: "Allianz Pojistovna a.s.",
        surnameOfDriver: "Z Ase",
        firstNameOfDriver: "Franta",
        addressOfDriver: "As",
        phoneNumberOfDriver: "1231223",
        driverLicenseNumber: "unknown",
        categoryOfLicense: "AM2",
        licenseIssuedBy: "Magistrat mesta Karlovy Vary"
    )
    
    
    @MainActor static let accidentReport = AccidentReport(
        id: UUID(),
        accidentLocation: AccidentLocation(
            date: Date(), city: "Prague", street: "Wenceslas Square", houseNumber: "1a", kilometerReading: "0", injuries: false,
            witnesses: [Witness.sample], otherDamage: false, policeInvolved: true
        ),
        driver: driverA,
        otherDriver: driverB,
        accidentDescription: AccidentDescription(notes1: "", notes2: "", vehicleDamage1: Array(repeating: false, count: 17),
            vehicleDamage2: Array(repeating: false, count: 17)),
        pointOfImpact1: nil,
        pointOfImpact2: nil,
        accidentSituation: AccidentSituation(roadShape: .crossroad)
    )
}
