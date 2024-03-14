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
                Text("Driver \(driverType == .driver1 ? "1" : "2") Information")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                VStack(alignment: .leading) {
                    TextField("Full Name", text: $presenter.accidentDriver.name)
                        .padding(.bottom)
                    
                    TextField("Address", text: $presenter.accidentDriver.address)
                        .padding(.bottom)
                    
                    TextField("Driver's License Number", text: $presenter.accidentDriver.driverLicenseNumber)
                        .padding(.bottom)
                    
                    TextField("Phone Number", text: $presenter.accidentDriver.phoneNumber)
                        .keyboardType(.phonePad)
                        .padding(.bottom)
                    
                    TextField("Vehicle Registration Plate", text: $presenter.accidentDriver.vehicleRegistrationPlate)
                        .padding(.bottom)
                    
                    TextField("Insurance Company", text: $presenter.accidentDriver.insuranceCompany)
                        .padding(.bottom)
                    
                    TextField("Insurance Policy Number", text: $presenter.accidentDriver.insurancePolicyNumber)
                        .padding(.bottom)
                    
                    Button(action: {
                        if presenter.viewState == .driver1 {
                            presenter.viewState = .driver2
                        } else {
                            presenter.saveReport()
                            presenter.viewState = .description
                        }
                    }) {
                        Label("Save Driver \(driverType == .driver1 ? "1" : "2") Information", systemImage: "checkmark.circle")
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
}

#Preview {
    DriverView(presenter: AccidentsPresenter(), driverType: .driver2)
}
