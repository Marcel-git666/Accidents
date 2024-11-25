//
//  ReportPreviewView.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.11.2024.
//

import SwiftUI


import SwiftUI

struct ReportPreviewView: View {
    let report: AccidentReport
    let templateImageName: String // Name of the background image in the bundle
    
    var body: some View {
        ZStack {
            // Background Image
            Image(templateImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 595.2, height: 841.8) // A4 dimensions in points
            
            // Overlay Text
            Text("\(report.accidentLocation.city), \(report.accidentLocation.street) \(report.accidentLocation.houseNumber)")
                .font(.system(size: 12)) // Small font for precise positioning
                .position(x: 245, y: 113) // Set to precise A4 coordinates
            if report.accidentLocation.injuries {
                Text("x")
                    .font(.system(size: 12))
                    .position(x: 504, y: 108)
            } else {
                Text("x")
                    .font(.system(size: 12))
                    .position(x: 456, y: 108)
            }
            // Example Additional Content
            Text("\(report.driver.insuredName)")
                .font(.system(size: 10))
                .position(x: 66, y: 210)
            Text("\(report.otherDriver?.insuredName ?? "Unknown")")
                .font(.system(size: 10))
                .position(x: 402, y: 210)
        }
        .frame(width: 595.2, height: 841.8)
    }
}


struct ReportPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock AccidentReport Data
        let mockReport = AccidentReport(
            id: UUID(),
            accidentLocation: AccidentLocation(
                date: Date(),
                city: "Brno",
                street: "Jirikovskeho",
                houseNumber: "123",
                kilometerReading: "50",
                injuries: true,
                witnesses: [],
                otherDamage: false,
                policeInvolved: false
            ),
            driver: Driver.sample1,
            otherDriver: Driver.sample2,
            accidentDescription: AccidentDescription(
                notes1: "Mock note 1",
                notes2: "Mock note 2",
                vehicleDamage1: Array(repeating: false, count: 17),
                vehicleDamage2: Array(repeating: false, count: 17)
            ),
            pointOfImpact1: nil,
            pointOfImpact2: nil,
            accidentSituation: AccidentSituation(roadShape: .crossroad)
        )
        ScrollView([.horizontal, .vertical]) {
            ReportPreviewView(report: mockReport, templateImageName: "form")
        }
    }
}
