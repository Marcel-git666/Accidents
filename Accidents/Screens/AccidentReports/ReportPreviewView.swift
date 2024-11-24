//
//  ReportPreviewView.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.11.2024.
//

import SwiftUI


struct ReportPreviewView: View {
    let report: AccidentReport
    let templateImageName: String // Name of the background image in the bundle
    
    var body: some View {
        ZStack {
            // PNG Template Background
            Image(templateImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 595.2, height: 841.8) // A4 dimensions in points
            
            // Overlay with Report Data
            VStack(alignment: .leading, spacing: 16) {
                Text("Accident Report")
                    .font(.title)
                    .bold()
                
                Text("Location: \(report.accidentLocation.city), \(report.accidentLocation.street)")
                    .font(.body)
                
                Text("Driver A: \(report.driver.insuredName)")
                    .font(.body)
                
                if let otherDriver = report.otherDriver {
                    Text("Driver B: \(otherDriver.insuredName)")
                        .font(.body)
                }
                
                Spacer()
            }
            .padding()
        }
        .frame(width: 595.2, height: 841.8) // Ensure the entire view conforms to A4
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
                injuries: false,
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
        
        ReportPreviewView(report: mockReport, templateImageName: "form")
    }
}
