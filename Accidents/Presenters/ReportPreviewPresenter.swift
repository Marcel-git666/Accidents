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
    @Published var driverInsuredName: String
    @Published var driverInsuredAddress: String
    @Published var driverInsuredPhone: String
    @Published var driverInsuredVAT: Bool
    @Published var driverCarType: String
    @Published var driverCarYear: String
    @Published var driverCarPlateNumber: String
    @Published var driverInsurer: String
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
        
        self.witnesses = report.accidentLocation.witnesses.map {
            "\($0.name), \($0.address), \($0.phoneNumber)"
        }
        // Driver
        self.driverInsuredName = report.driver.insuredName
        self.driverInsuredAddress = report.driver.insuredAddress
        self.driverInsuredPhone = report.driver.insuredPhone
        self.driverInsuredVAT = report.driver.insuredPayerOfVAT
        self.driverCarType = report.driver.vehicleManufacturerAndType
        self.driverCarYear = report.driver.vehicleYearOfManufacture
        self.driverCarPlateNumber = report.driver.vehicleStateRegistrationPlate
        self.driverInsurer = report.driver.insurer
        
        // Initialize arrow settings (default values or from the report if available)
        self.arrowPosition = report.pointOfImpact1?.crashPoint ?? CGPoint(x: 0, y: 0)
        self.arrowRotation = report.pointOfImpact1?.arrowRotation ?? 0
        self.arrowScale = report.pointOfImpact1?.scale ?? 0
        if self.arrowScale != 0 {
            updateArrow(x: -200, y: 460)
        }
        
    }
        
    func updateArrow(x: Double, y: Double) {
        arrowPosition.x += x
        arrowPosition.y += y
        arrowScale *= 0.2
    }
}
