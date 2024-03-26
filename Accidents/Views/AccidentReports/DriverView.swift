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
                ScrollView {
                    TitledBorderTextField(title: "Full Name", text: presenter.selectedTab == .driver1 ? $presenter.accidentDriver1.name : $presenter.accidentDriver2.name, placeholder: "Full name", titleColor: .accentColor)
                        .padding(.top)
                    TitledBorderTextField(title: "Address", text: presenter.selectedTab == .driver1 ? $presenter.accidentDriver1.address : $presenter.accidentDriver2.address, placeholder: "Address", titleColor: .accentColor)
                    
                    TitledBorderTextField(title: "Driver's License Number", text: presenter.selectedTab == .driver1 ? $presenter.accidentDriver1.driverLicenseNumber : $presenter.accidentDriver2.driverLicenseNumber, placeholder: "Driver's license number", titleColor: .accentColor)
                    
                    TitledBorderTextField(title: "Phone Number", text: presenter.selectedTab == .driver1 ? $presenter.accidentDriver1.phoneNumber : $presenter.accidentDriver2.phoneNumber, placeholder: "Phone Number", titleColor: .accentColor)
                        .keyboardType(.phonePad)
                    
                    TitledBorderTextField(title: "Vehicle Registration Plate", text: presenter.selectedTab == .driver1 ? $presenter.accidentDriver1.vehicleRegistrationPlate : $presenter.accidentDriver2.vehicleRegistrationPlate, placeholder: "Vehicle Registration Plate", titleColor: .accentColor)
                    
                    TitledBorderTextField(title: "Insurance Company", text: presenter.selectedTab == .driver1 ? $presenter.accidentDriver1.insuranceCompany : $presenter.accidentDriver2.insuranceCompany, placeholder: "Insurance Company", titleColor: .accentColor)
                    
                    TitledBorderTextField(title: "Insurance Policy Number", text: presenter.selectedTab == .driver1 ? $presenter.accidentDriver1.insurancePolicyNumber : $presenter.accidentDriver2.insurancePolicyNumber, placeholder: "Insurance Policy Number", titleColor: .accentColor)
                        
                    
                    
                }
                .padding()
                Spacer()
                SaveButton(label: "Save Driver \(driverType == .driver1 ? "A" : "B") Information", systemImage: "checkmark.circle", action: {
                    presenter.goNext()
                })
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DriverView(presenter: AccidentsPresenter(repository: CoreDataRepository()), driverType: .driver2)
            .navigationTitle("Driver A")
    }
}
