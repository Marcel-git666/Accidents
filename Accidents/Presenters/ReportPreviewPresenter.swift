//
//  ReportPreviewPresenter.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.11.2024.
//

import SwiftUI

class ReportPreviewPresenter: ObservableObject {
    let report: AccidentReport
    
    // Processed data for the view
    @Published var formattedDate: String
    @Published var formattedTime: String
    @Published var isInjuriesChecked: Bool
    @Published var arrowPosition: CGPoint
    @Published var arrowRotation: Double
    @Published var arrowScale: CGFloat
    @Published var isPoliceInvolved: Bool
    @Published var isOtherDamage: Bool
    @Published var witnesses: [String] = []
    @Published var driverDetails: DriverDetails
    @Published var vehicleDamage1: [Bool]
    @Published var vehicleDamage2: [Bool]
    var dateString: String
    
    init(report: AccidentReport) {
        self.report = report
        
        // Process the accident date into separate strings
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.formattedDate = dateFormatter.string(from: report.accidentLocation.date)
        
        dateFormatter.dateFormat = "HH:mm"
        self.formattedTime = dateFormatter.string(from: report.accidentLocation.date)
        // Handle checkboxes and other attributes
        self.isInjuriesChecked = report.accidentLocation.injuries
        self.isPoliceInvolved = report.accidentLocation.policeInvolved
        self.isOtherDamage = report.accidentLocation.otherDamage
        self.vehicleDamage1 = report.accidentDescription.vehicleDamage1
        self.vehicleDamage2 = report.accidentDescription.vehicleDamage2
        self.witnesses = report.accidentLocation.witnesses.map {
            "\($0.name), \($0.address), \($0.phoneNumber)"
        }
        // Driver
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateString = dateFormatter.string(from: report.driver.borderInsuranceValidUntil)
        self.driverDetails = DriverDetails(insuredName: report.driver.insuredName, insuredAddress: report.driver.insuredAddress, insuredPhone: report.driver.insuredPhone, insuredVat: report.driver.insuredPayerOfVAT, carType: report.driver.vehicleManufacturerAndType, carYear: report.driver.vehicleYearOfManufacture, plateNumber: report.driver.vehicleStateRegistrationPlate, insurer: report.driver.insurer, insurerBranchAddress: report.driver.insurerBranchAddress, insuranceNumber: report.driver.insuranceNumber, greenCardNumber: report.driver.greenCardNumber, borderInsuranceValidUntil: dateString, comprehensiveInsurance: report.driver.comprehensiveInsurance, comprehensiveInsuranceCompany: report.driver.comprehensiveInsuranceCompany, surnameOfDriver: report.driver.surnameOfDriver, firstNameOfDriver: report.driver.firstNameOfDriver, addressOfDriver: report.driver.addressOfDriver, phoneNumberOfDriver: report.driver.phoneNumberOfDriver, driverLicenseNumber: report.driver.driverLicenseNumber, categoryOfLicense: report.driver.categoryOfLicense, licenseIssuedBy: report.driver.licenseIssuedBy)
        
        
        // Initialize arrow settings (default values or from the report if available)
        self.arrowPosition = report.pointOfImpact1?.crashPoint ?? CGPoint(x: 0, y: 0)
        self.arrowRotation = report.pointOfImpact1?.arrowRotation ?? 0
        self.arrowScale = report.pointOfImpact1?.scale ?? 0
        if self.arrowScale != 0 {
            updateArrow(x: -200, y: 460)
        }
        
    }
    // swiftlint:disable identifier_name
    func updateArrow(x: Double, y: Double) {
        arrowPosition.x += x
        arrowPosition.y += y
        arrowScale *= 0.2
    }
    // swiftlint:enable identifier_name
}

struct DriverDetails {
    var insuredName: String
    var insuredAddress: String
    var insuredPhone: String
    var insuredVat: Bool
    var carType: String
    var carYear: String
    var plateNumber: String
    var insurer: String
    var insurerBranchAddress: String
    var insuranceNumber: String
    var greenCardNumber: String
    var borderInsuranceValidUntil: String
    var comprehensiveInsurance: Bool
    var comprehensiveInsuranceCompany: String
    var surnameOfDriver: String
    var firstNameOfDriver: String
    var addressOfDriver: String
    var phoneNumberOfDriver: String
    var driverLicenseNumber: String
    var categoryOfLicense: String
    var licenseIssuedBy: String
    
}
