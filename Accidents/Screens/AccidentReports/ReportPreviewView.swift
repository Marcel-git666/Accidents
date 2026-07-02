//
//  ReportPreviewView.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.11.2024.
//

import SwiftUI

struct ReportPreviewView: View {
    let presenter: ReportPreviewPresenter
    let templateImageName: String
    
    var body: some View {
        ZStack {
            // Background Image
            Image(templateImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 595.2, height: 841.8)
            
            LocationDetailsView(
                city: presenter.report.accidentLocation.city,
                street: presenter.report.accidentLocation.street,
                houseNumber: presenter.report.accidentLocation.houseNumber
            )
            
            DateTimeView(
                date: presenter.formattedDate,
                time: presenter.formattedTime
            )
            WitnessesView(witnesses: presenter.witnesses)
            CheckboxesView(
                isInjuriesChecked: presenter.isInjuriesChecked,
                isPoliceInvolved: presenter.isPoliceInvolved,
                isOtherDamage: presenter.isOtherDamage,
                isDriverInsuredVAT: presenter.driver1.insuredPayerOfVAT,
                hasComprehensiveInsurance: presenter.driver1.comprehensiveInsurance,
                vehicle1Damage: presenter.vehicleDamage1,
                vehicle2Damage: presenter.vehicleDamage2
            )
            // Driver A information
            DriverInfoSection(
                driver: presenter.driver1,
                formattedInsuranceDate: presenter.formattedInsuranceDate1,
                isDriverA: true
            )
            
            // Driver B information
            DriverInfoSection(
                driver: presenter.driver2,
                formattedInsuranceDate: presenter.formattedInsuranceDate2,
                isDriverA: false
            )
            // Arrows for point of impact — Vehicle A and B
            if let impact = presenter.pointOfImpact1 {
                // 1. O kolik musíme zmenšit souřadnice z telefonu, aby seděly do malého PDF (odhad 35%)
                let diagramScale: CGFloat = 0.35
                
                // 2. Posun levého horního rohu na modrou sekci 10
                let offsetXA: CGFloat = 25
                let offsetYA: CGFloat = 540
                
                DraggableArrowView()
                    .rotationEffect(.degrees(impact.arrowRotation), anchor: .bottom)
                // Zmenšíme samotnou šipku, aby nebyla obří
                    .scaleEffect(impact.scale * diagramScale)
                // Převodní vzorec: (původní_bod * zmenšení) + posun_na_papíře
                    .position(
                        x: (impact.x * diagramScale) + offsetXA,
                        y: (impact.y * diagramScale) + offsetYA
                    )
            }
            
            if let impact = presenter.pointOfImpact2 {
                let diagramScale: CGFloat = 0.35
                
                // Posun levého horního rohu na žlutou sekci 10 (Y musí být stejné jako u A)
                let offsetXB: CGFloat = 420
                let offsetYB: CGFloat = 540
                
                DraggableArrowView()
                    .rotationEffect(.degrees(impact.arrowRotation), anchor: .bottom)
                    .scaleEffect(impact.scale * diagramScale)
                    .position(
                        x: (impact.x * diagramScale) + offsetXB,
                        y: (impact.y * diagramScale) + offsetYB
                    )
            }
            
        }
        .environment(\.colorScheme, .light)
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
                city: "Pardubice",
                street: "Jirikovskeho",
                houseNumber: "123",
                kilometerReading: "50",
                injuries: true,
                witnesses: [Witness(name: "Random Witness", address: "Litomerice, Arne Novaka 5656", phoneNumber: "+420123456000"), Witness(name: "Pepa von Depo", address: "Short address", phoneNumber: "123456789"), Witness(name: "Hidden Witness", address: "Hidden address", phoneNumber: "none")],
                otherDamage: true,
                policeInvolved: true
            ),
            driver: PreviewData.driverA,
            otherDriver: PreviewData.driverB,
            accidentDescription: AccidentDescription(
                notes1: "Mock note 1",
                notes2: "Mock note 2",
                vehicleDamage1: Array(repeating: true, count: 17),
                vehicleDamage2: Array(repeating: true, count: 17)
            ),
            pointOfImpact1: PointOfImpact(x: 200, y: 100, arrowRotation: 45, scale: 0.8),
            pointOfImpact2: nil,
            accidentSituation: AccidentSituation(roadShape: .crossroad)
        )
        ScrollView([.horizontal, .vertical]) {
            ReportPreviewView(presenter: ReportPreviewPresenter(report: mockReport), templateImageName: "form")
        }
    }
}
