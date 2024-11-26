//
//  ReportPreviewView.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.11.2024.
//

import SwiftUI


struct ReportPreviewView: View {
    @ObservedObject var presenter: ReportPreviewPresenter
    let templateImageName: String
    
    var body: some View {
        ZStack {
            // Background Image
            Image(templateImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 595.2, height: 841.8) // A4 dimensions
            
            // Overlay Text and Components
            Group {
                // Location details
                Text("\(presenter.report.accidentLocation.city), \(presenter.report.accidentLocation.street) \(presenter.report.accidentLocation.houseNumber)")
                    .font(.system(size: 12))
                    .frame(width: 200, height: 20, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .truncationMode(.tail)
                    .position(x: 285, y: 113)
                
                // Date and Time
                Text(presenter.formattedDate)
                    .font(.system(size: 10))
                    .position(x: 80, y: 113)
                Text(presenter.formattedTime)
                    .font(.system(size: 10))
                    .position(x: 155, y: 113)
                Text("\(presenter.witnesses.first ?? "no witnesses")")
                        .font(.system(size: 10))
                        .frame(width: 200, height: 12, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .truncationMode(.tail)
                        .position(x: 285, y: 140)
                // Second witness (if available)
                    if presenter.witnesses.count > 1 {
                        Text(presenter.witnesses[1])
                            .font(.system(size: 10))
                            .frame(width: 200, height: 12, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .truncationMode(.tail)
                            .position(x: 285, y: 150)
                    }
                    
                    // Ellipsis for additional witnesses
                    if presenter.witnesses.count > 2 {
                        Text("...")
                            .font(.system(size: 10))
                            .frame(width: 200, height: 8, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .position(x: 285, y: 155)
                    }
                // Injuries Checkbox
                if presenter.isInjuriesChecked {
                    Text("x").font(.system(size: 12)).position(x: 504, y: 108)
                } else {
                    Text("x").font(.system(size: 12)).position(x: 456, y: 108)
                }
                if presenter.isPoliceInvolved {
                    Text("x").font(.system(size: 12)).position(x: 504, y: 141)
                } else {
                    Text("x").font(.system(size: 12)).position(x: 456, y: 141)
                }
                if presenter.isOtherDamage {
                    Text("x").font(.system(size: 12)).position(x: 146, y: 146)
                } else {
                    Text("x").font(.system(size: 12)).position(x: 99, y: 146)
                }
            }
            
            // Arrow for point of impact
            DraggableArrowView(
                crashPoint: presenter.arrowPosition,
                scale: presenter.arrowScale,
                arrowRotation: presenter.arrowRotation
            )
            .rotationEffect(.degrees(presenter.arrowRotation), anchor: .bottom)
            .scaleEffect(presenter.arrowScale)
            .position(presenter.arrowPosition)
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
                city: "Pardubice",
                street: "Jirikovskeho",
                houseNumber: "123",
                kilometerReading: "50",
                injuries: true,
                witnesses: [Witness(name: "Random Witness", address: "Litomerice, Arne Novaka 5656", phoneNumber: "+420123456000"), Witness(name: "Pepa von Depo", address: "Short address", phoneNumber: "123456789"), Witness(name: "Hidden Witness", address: "Hidden address", phoneNumber: "none")],
                otherDamage: true,
                policeInvolved: true
            ),
            driver: Driver(insuredName: "Pepa Novak", insuredAddress: "Brno, namesti Svobody 8", insuredPhone: "+420777888999", insuredPayerOfVAT: true, vehicleManufacturerAndType: "Volkswagen", vehicleYearOfManufacture: "1999", vehicleStateRegistrationPlate: "B 123456", insurer: "Česká podnikatelská pojišťovna a.s.", insurerBranchAddress: "Praha 16, Václavské náměstí 23", insuranceNumber: "456456456", greenCardNumber: "789456123", borderInsuranceValidUntil: Date(), comprehensiveInsurance: true, comprehensiveInsuranceCompany: "Doplňková pojistka", surnameOfDriver: "VodNovákaPrateta", firstNameOfDriver: "Vladislava", addressOfDriver: "To raději nechtěj vědět vodkaď sem", phoneNumberOfDriver: "+420123456789", driverLicenseNumber: "4567895asb", categoryOfLicense: "ABCDE", licenseIssuedBy: "Magistrát města Litomyšle"),
            otherDriver: Driver.sample2,
            accidentDescription: AccidentDescription(
                notes1: "Mock note 1",
                notes2: "Mock note 2",
                vehicleDamage1: Array(repeating: true, count: 17),
                vehicleDamage2: Array(repeating: true, count: 17)
            ),
            pointOfImpact1: nil,
            pointOfImpact2: nil,
            accidentSituation: AccidentSituation(roadShape: .crossroad)
        )
        ScrollView([.horizontal, .vertical]) {
            ReportPreviewView(presenter: ReportPreviewPresenter(report: mockReport), templateImageName: "form")
        }
    }
}
