//
//  ReportPreviewPresenter.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.11.2024.
//

import SwiftUI

@MainActor
@Observable
class ReportPreviewPresenter {
    let report: AccidentReport

    // Processed data for the view
    var formattedDate: String
    var formattedTime: String
    var isInjuriesChecked: Bool
    var isPoliceInvolved: Bool
    var isOtherDamage: Bool
    var witnesses: [String] = []
    var vehicleDamage1: [Bool]
    var vehicleDamage2: [Bool]
    var driver1: Driver
    var driver2: Driver
    var pointOfImpact1: PointOfImpact?
    var pointOfImpact2: PointOfImpact?

    var formattedInsuranceDate1: String {
        formatDate(driver1.borderInsuranceValidUntil)
    }
    
    var formattedInsuranceDate2: String {
        formatDate(driver2.borderInsuranceValidUntil)
    }

    init(report: AccidentReport) {
        self.report = report
        self.driver1 = report.driver ?? PreviewData.driverA
        self.driver2 = report.otherDriver ?? PreviewData.driverB
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
        self.pointOfImpact1 = report.pointOfImpact1
        self.pointOfImpact2 = report.pointOfImpact2
        self.witnesses = report.accidentLocation.witnesses.map {
            "\($0.name), \($0.address), \($0.phoneNumber)"
        }
    }
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }

    // swiftlint:disable identifier_name

    // swiftlint:enable identifier_name
}
