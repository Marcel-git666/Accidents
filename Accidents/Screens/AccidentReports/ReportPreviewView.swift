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
            // Arrow for point of impact
            //            DraggableArrowView(
            //                crashPoint: presenter.arrowPosition,
            //                scale: presenter.arrowScale,
//                arrowRotation: presenter.arrowRotation
//            )
//            .rotationEffect(.degrees(presenter.arrowRotation), anchor: .bottom)
//            .scaleEffect(presenter.arrowScale)
//            .position(presenter.arrowPosition)
            
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
            driver: Driver(insuredName: "Pepa Novak", insuredAddress: "Brno, namesti Svobody 8", insuredPhone: "+420777888999", insuredPayerOfVAT: false, vehicleManufacturerAndType: "Volkswagen", vehicleYearOfManufacture: "1999", vehicleStateRegistrationPlate: "B 123456", insurer: "Česká podnikatelská pojišťovna a.s.", insurerBranchAddress: "Praha 16, Václavské náměstí 23", insuranceNumber: "456456456", greenCardNumber: "789456123", borderInsuranceValidUntil: Date(), comprehensiveInsurance: true, comprehensiveInsuranceCompany: "Allianz havarijní pojistka", surnameOfDriver: "VodNovákaPrateta", firstNameOfDriver: "Vladislava", addressOfDriver: "To raději nechtěj vědět vodkaď sem", phoneNumberOfDriver: "+420123456789", driverLicenseNumber: "4567895asb", categoryOfLicense: "ABCDE", licenseIssuedBy: "Magistrát města Litomyšle"),
            otherDriver: Driver.sample2,
            accidentDescription: AccidentDescription(
                notes1: "Mock note 1",
                notes2: "Mock note 2",
                vehicleDamage1: Array(repeating: true, count: 17),
                vehicleDamage2: Array(repeating: true, count: 17)
            ),
            pointOfImpact1: PointOfImpact(crashPoint: CGPoint(x: 200, y: 100), arrowRotation: 45, scale: 0.8),
            pointOfImpact2: nil,
            accidentSituation: AccidentSituation(roadShape: .crossroad)
        )
        ScrollView([.horizontal, .vertical]) {
            ReportPreviewView(presenter: ReportPreviewPresenter(report: mockReport), templateImageName: "form")
        }
    }
}
