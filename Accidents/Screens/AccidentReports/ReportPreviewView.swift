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
                isDriverInsuredVAT: presenter.driverDetails.insuredVat,
                hasComprehensiveInsurance: presenter.driverDetails.comprehensiveInsurance
            )
            Text("\(presenter.driverDetails.insuredName)")
                .font(.system(size: 10))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 150, y: 210)
            Text("\(presenter.driverDetails.insuredAddress)")
                .font(.system(size: 10))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 150, y: 230)
            Text("\(presenter.driverDetails.insuredPhone)")
                .font(.system(size: 10))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 225, y: 248)
            Text("\(presenter.driverDetails.carType)")
                .font(.system(size: 10))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 205, y: 295)
            Text("\(presenter.driverDetails.carYear)")
                .font(.system(size: 10))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 205, y: 310)
            Text("\(presenter.driverDetails.plateNumber)")
                .font(.system(size: 10))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 235, y: 329)
            Text("\(presenter.driverDetails.insurer)")
                .font(.system(size: 10))
                .frame(width: 100, height: 40, alignment: .leading)
                .multilineTextAlignment(.center)
                .truncationMode(.tail)
                .position(x: 145, y: 355)
            Text("\(presenter.driverDetails.insurerBranchAddress)")
                .font(.system(size: 9))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 145, y: 377)
            Text("\(presenter.driverDetails.insuranceNumber )")
                .font(.system(size: 9))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 230, y: 390)
            Text("\(presenter.driverDetails.greenCardNumber)")
                .font(.system(size: 9))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 230, y: 405)
            Text("\(presenter.driverDetails.borderInsuranceValidUntil)")
                .font(.system(size: 10))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 250, y: 425)
            Text("\(presenter.driverDetails.comprehensiveInsuranceCompany)")
                .font(.system(size: 8))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 180, y: 462)
            Text("\(presenter.driverDetails.surnameOfDriver)")
                .font(.system(size: 10))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 180, y: 482)
            Text("\(presenter.driverDetails.firstNameOfDriver)")
                .font(.system(size: 10))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 180, y: 497)
            Text("\(presenter.driverDetails.addressOfDriver)")
                .font(.system(size: 10))
                .frame(width: 150, height: 40, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 150, y: 517)
            Text("\(presenter.driverDetails.driverLicenseNumber)")
                .font(.system(size: 10))
                .frame(width: 200, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 233, y: 537)
            Text("\(presenter.driverDetails.categoryOfLicense)")
                .font(.system(size: 10))
                .frame(width: 100, height: 15, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 130, y: 555)
            Text("\(presenter.driverDetails.licenseIssuedBy)")
                .font(.system(size: 8))
                .frame(width: 100, height: 20, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 190, y: 555)
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
            driver: Driver(insuredName: "Pepa Novak", insuredAddress: "Brno, namesti Svobody 8", insuredPhone: "+420777888999", insuredPayerOfVAT: true, vehicleManufacturerAndType: "Volkswagen", vehicleYearOfManufacture: "1999", vehicleStateRegistrationPlate: "B 123456", insurer: "Česká podnikatelská pojišťovna a.s.", insurerBranchAddress: "Praha 16, Václavské náměstí 23", insuranceNumber: "456456456", greenCardNumber: "789456123", borderInsuranceValidUntil: Date(), comprehensiveInsurance: true, comprehensiveInsuranceCompany: "Allianz havarijní pojistka", surnameOfDriver: "VodNovákaPrateta", firstNameOfDriver: "Vladislava", addressOfDriver: "To raději nechtěj vědět vodkaď sem", phoneNumberOfDriver: "+420123456789", driverLicenseNumber: "4567895asb", categoryOfLicense: "ABCDE", licenseIssuedBy: "Magistrát města Litomyšle"),
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
