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
                    Text("Insurer")
                    TitledBorderTextField(title: "Insurer name", text: $driver.insuredName, placeholder: "Full name", titleColor: .accentColor)
                        .padding(.top)
                    TitledBorderTextField(title: "Insurer Address", text: $driver.insuredAddress, placeholder: "Address", titleColor: .accentColor)
                    TitledBorderTextField(title: "Phone from 9 to 16", text: $driver.insuredPhone, placeholder: "Phone from 9 to 16", titleColor: .accentColor)
                    HStack(alignment: .center) {
                        TickBox(text: "Payer of VAT?", isSelected:  $driver.insuredPayerOfVAT)
                    }
                    Text("Vehicle")
                    TitledBorderTextField(title: "Manufacturer, type", text: $driver.vehicleManufacturerAndType, placeholder: "Manufacturer, type", titleColor: .accentColor)
                    TitledBorderTextField(title: "Year of manufacture", text: $driver.vehicleYearOfManufacture, placeholder: "Year of manufacture", titleColor: .accentColor)
                    TitledBorderTextField(title: "Vehicle Registration Plate", text: $driver.vehicleStateRegistrationPlate, placeholder: "Vehicle Registration Plate", titleColor: .accentColor)
                    Text("Insurer")
                    TitledBorderTextField(title: "Insurance Company Name", text: $driver.insurer, placeholder: "Insurance Company Name", titleColor: .accentColor)
                    TitledBorderTextField(title: "Insurer Address", text: $driver.insurerBranchAddress, placeholder: "Insurer Address", titleColor: .accentColor)
                    TitledBorderTextField(title: "Insurance Policy Number", text: $driver.insuranceNumber, placeholder: "Insurance Policy Number", titleColor: .accentColor)
                    TitledBorderTextField(title: "Green Card Number", text: $driver.greenCardNumber, placeholder: "Green Card Number", titleColor: .accentColor)
                    DatePicker("Border insurance valid until", selection: $driver.borderInsuranceValidUntil, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .foregroundColor(.accentColor)
                        .padding(.horizontal)
                        .padding(.bottom, 6)
                    HStack(alignment: .center) {
                        TickBox(text: "Has vehicle comprehensive insurance?", isSelected:  $driver.comprehensiveInsurance)
                    }
                    TitledBorderTextField(title: "Comprehensive Insurance Company", text: $driver.comprehensiveInsuranceCompany, placeholder: "Insurance Company", titleColor: .accentColor)
                    Text("Driver")
                    TitledBorderTextField(title: "Surname", text: $driver.surnameOfDriver, placeholder: "Surname", titleColor: .accentColor)
                    TitledBorderTextField(title: "First name", text: $driver.firstNameOfDriver, placeholder: "Name", titleColor: .accentColor)
                    TitledBorderTextField(title: "Driver's License Number", text: $driver.driverLicenseNumber, placeholder: "Driver's license number", titleColor: .accentColor)
                    TitledBorderTextField(title: "Category", text: $driver.categoryOfLicense, placeholder: "Category", titleColor: .accentColor)
                    TitledBorderTextField(title: "Issued by", text: $driver.licenseIssuedBy, placeholder: "Issued by", titleColor: .accentColor)
                }
                .padding()
                Spacer()
                HStack {
                    ACButton(label: "Exit and save", systemImage: "checkmark.circle") {
                        presenter.createReportAndSave()
                    }
                    ACButton(label: "Save & Go next", systemImage: "goforward.plus") {
                            presenter.goNext()
                    }
                }
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
