//
//  DriverView.swift
//  Accidents
//
//  Created by Marcel Mravec on 05.03.2024.
//

import SwiftUI

struct DriverView: View {
    @ObservedObject var presenter: AccidentsPresenter
    @Binding var driver: Driver
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ScrollView {
                    TitledBorderTextField(title: "Full Name", text: $driver.name, placeholder: "Full name", titleColor: .accentColor)
                        .padding(.top)
                    TitledBorderTextField(title: "Address", text: $driver.address, placeholder: "Address", titleColor: .accentColor)
                    
                    TitledBorderTextField(title: "Driver's License Number", text: $driver.driverLicenseNumber, placeholder: "Driver's license number", titleColor: .accentColor)
                    
                    TitledBorderTextField(title: "Phone Number", text: $driver.phoneNumber, placeholder: "Phone Number", titleColor: .accentColor)
                        .keyboardType(.phonePad)
                    
                    TitledBorderTextField(title: "Vehicle Registration Plate", text: $driver.vehicleRegistrationPlate, placeholder: "Vehicle Registration Plate", titleColor: .accentColor)
                    
                    TitledBorderTextField(title: "Insurance Company", text: $driver.insuranceCompany, placeholder: "Insurance Company", titleColor: .accentColor)
                    
                    TitledBorderTextField(title: "Insurance Policy Number", text: $driver.insurancePolicyNumber, placeholder: "Insurance Policy Number", titleColor: .accentColor)
                }
                .padding()
                Spacer()
                SaveButton(label: "Save Driver \(presenter.selectedTab == .driver1 ? "A" : "B") Information", systemImage: "checkmark.circle", action: {
                    presenter.goNext()
                })
                .padding()
            }
        }
    }
}


struct DriverView_Previews: PreviewProvider {
  static var previews: some View {
    let driver = AccidentReport.sampleData.driver
    return NavigationStack {
      DriverView(presenter: MockPresenter(repository: MockDataRepository()), driver: { () -> Binding<Driver> in
        return Binding<Driver>(get: { driver }, set: { newValue in
          // Optional: Update your mock data or handle changes here if needed
        })
      }())
        .navigationTitle("Driver A")
    }
  }
}
