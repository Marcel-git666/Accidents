//
//  Driver.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.06.2026.
//

import SwiftData
import SwiftUI

@Model
class Driver {
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
    
    init(
        insuredName: String = "",
        insuredAddress: String = "",
        insuredPhone: String = "",
        insuredPayerOfVAT: Bool = false,
        vehicleManufacturerAndType: String = "",
        vehicleYearOfManufacture: String = "",
        vehicleStateRegistrationPlate: String = "",
        insurer: String = "",
        insurerBranchAddress: String = "",
        insuranceNumber: String = "",
        greenCardNumber: String = "",
        borderInsuranceValidUntil: Date = Date(),
        comprehensiveInsurance: Bool = false,
        comprehensiveInsuranceCompany: String = "",
        surnameOfDriver: String = "",
        firstNameOfDriver: String = "",
        addressOfDriver: String = "",
        phoneNumberOfDriver: String = "",
        driverLicenseNumber: String = "",
        categoryOfLicense: String = "",
        licenseIssuedBy: String = ""
    ) {
        self.insuredName = insuredName
        self.insuredAddress = insuredAddress
        self.insuredPhone = insuredPhone
        self.insuredPayerOfVAT = insuredPayerOfVAT
        self.vehicleManufacturerAndType = vehicleManufacturerAndType
        self.vehicleYearOfManufacture = vehicleYearOfManufacture
        self.vehicleStateRegistrationPlate = vehicleStateRegistrationPlate
        self.insurer = insurer
        self.insurerBranchAddress = insurerBranchAddress
        self.insuranceNumber = insuranceNumber
        self.greenCardNumber = greenCardNumber
        self.borderInsuranceValidUntil = borderInsuranceValidUntil
        self.comprehensiveInsurance = comprehensiveInsurance
        self.comprehensiveInsuranceCompany = comprehensiveInsuranceCompany
        self.surnameOfDriver = surnameOfDriver
        self.firstNameOfDriver = firstNameOfDriver
        self.addressOfDriver = addressOfDriver
        self.phoneNumberOfDriver = phoneNumberOfDriver
        self.driverLicenseNumber = driverLicenseNumber
        self.categoryOfLicense = categoryOfLicense
        self.licenseIssuedBy = licenseIssuedBy
    }
}
