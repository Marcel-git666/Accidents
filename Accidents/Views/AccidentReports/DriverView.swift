//
//  DriverView.swift
//  Accidents
//
//  Created by Marcel Mravec on 05.03.2024.
//

import SwiftUI

struct DriverView: View {
    @ObservedObject var presenter: AccidentsPresenter
    let driverType: DriverType
        
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    TextField("Full Name", text: presenter.viewState == .driver1 ? $presenter.accidentDriver1.name : $presenter.accidentDriver2.name)
                        .padding(.bottom)
                    
                    TextField("Address", text: presenter.viewState == .driver1 ? $presenter.accidentDriver1.address : $presenter.accidentDriver2.address)
                        .padding(.bottom)
                    
                    TextField("Driver's License Number", text: presenter.viewState == .driver1 ? $presenter.accidentDriver1.driverLicenseNumber : $presenter.accidentDriver2.driverLicenseNumber)
                        .padding(.bottom)
                    
                    TextField("Phone Number", text: presenter.viewState == .driver1 ? $presenter.accidentDriver1.phoneNumber : $presenter.accidentDriver2.phoneNumber)
                        .keyboardType(.phonePad)
                        .padding(.bottom)
                    
                    TextField("Vehicle Registration Plate", text: presenter.viewState == .driver1 ? $presenter.accidentDriver1.vehicleRegistrationPlate : $presenter.accidentDriver2.vehicleRegistrationPlate)
                        .padding(.bottom)
                    
                    TextField("Insurance Company", text: presenter.viewState == .driver1 ? $presenter.accidentDriver1.insuranceCompany : $presenter.accidentDriver2.insuranceCompany)
                        .padding(.bottom)
                    
                    TextField("Insurance Policy Number", text: presenter.viewState == .driver1 ? $presenter.accidentDriver1.insurancePolicyNumber : $presenter.accidentDriver2.insurancePolicyNumber)
                        .padding(.bottom)
                    
                    Button(action: {
                        if presenter.viewState == .driver1 {
                            presenter.goNext()
                        } else {
                            saveReportAction()
                        }
                    }) {
                        Label("Save Driver \(driverType == .driver1 ? "A" : "B") Information", systemImage: "checkmark.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity, minHeight: 52)
                            .background(.black)
                            .cornerRadius(15)
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
    
    func saveReportAction() {
        presenter.createReportAndSave()
        presenter.goNext()
    }
}

#Preview {
    NavigationStack {
        DriverView(presenter: AccidentsPresenter(repository: CoreDataRepository()), driverType: .driver2)
            .navigationTitle("Test Driver 99")
    }
}
