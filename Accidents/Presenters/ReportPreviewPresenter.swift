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
    @Published var isPoliceInvolved: Bool
    @Published var isOtherDamage: Bool
    @Published var witnesses: [String] = []
    @Published var vehicleDamage1: [Bool]
    @Published var vehicleDamage2: [Bool]
    @Published var driver1: Driver
    @Published var driver2: Driver

//    // Points of impact
//    @Published var arrowPosition1: CGPoint
//    @Published var arrowRotation1: Double
//    @Published var arrowScale1: CGFloat
//    @Published var arrowPosition2: CGPoint
//    @Published var arrowRotation2: Double
//    @Published var arrowScale2: CGFloat

    var formattedInsuranceDate1: String {
        formatDate(driver1.borderInsuranceValidUntil)
    }
    
    var formattedInsuranceDate2: String {
        formatDate(driver2.borderInsuranceValidUntil)
    }

    init(report: AccidentReport) {
        self.report = report
        self.driver1 = report.driver
        self.driver2 = report.otherDriver ?? Driver.sample2
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
    }
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }

    // swiftlint:disable identifier_name

    // swiftlint:enable identifier_name
}
