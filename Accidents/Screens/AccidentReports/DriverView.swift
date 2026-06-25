//
//  DriverView.swift
//  Accidents
//

import SwiftUI

struct DriverView: View {
    @Bindable var model: DriverViewModel

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ScrollView {
                    Text("Insurer")
                    TitledBorderTextField(title: "Insurer name", text: $model.driver.insuredName, placeholder: "Full name", titleColor: .accentColor)
                        .padding(.top)
                    TitledBorderTextField(title: "Insurer Address", text: $model.driver.insuredAddress, placeholder: "Address", titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "Phone from 9 to 16", text: $model.driver.insuredPhone,
                        placeholder: "Phone from 9 to 16",
                        titleColor: .accentColor)
                    HStack(alignment: .center) {
                        TickBox(text: "Payer of VAT?", isSelected: $model.driver.insuredPayerOfVAT)
                    }
                    Text("Vehicle")
                    TitledBorderTextField(
                        title: "Manufacturer, type", text: $model.driver.vehicleManufacturerAndType,
                        placeholder: "Manufacturer, type",
                        titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "Year of manufacture", text: $model.driver.vehicleYearOfManufacture,
                        placeholder: "Year of manufacture",
                        titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "Vehicle Registration Plate",
                        text: $model.driver.vehicleStateRegistrationPlate,
                        placeholder: "Vehicle Registration Plate",
                        titleColor: .accentColor)
                    Text("Insurer")
                    TitledBorderTextField(
                        title: "Insurance Company Name",
                        text: $model.driver.insurer,
                        placeholder: "Insurance Company Name",
                        titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "Insurer Address",
                        text: $model.driver.insurerBranchAddress,
                        placeholder: "Insurer Address", titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "Insurance Policy Number",
                        text: $model.driver.insuranceNumber,
                        placeholder: "Insurance Policy Number",
                        titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "Green Card Number",
                        text: $model.driver.greenCardNumber,
                        placeholder: "Green Card Number",
                        titleColor: .accentColor)
                    DatePicker("Border insurance valid until",
                               selection: $model.driver.borderInsuranceValidUntil,
                               displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .foregroundColor(.accentColor)
                        .padding(.horizontal)
                        .padding(.bottom, 6)
                    HStack(alignment: .center) {
                        TickBox(text: "Has vehicle comprehensive insurance?", isSelected: $model.driver.comprehensiveInsurance)
                    }
                    TitledBorderTextField(
                        title: "Comprehensive Insurance Company",
                        text: $model.driver.comprehensiveInsuranceCompany,
                        placeholder: "Insurance Company",
                        titleColor: .accentColor)
                    Text("Driver")
                    TitledBorderTextField(
                        title: "Surname", text: $model.driver.surnameOfDriver,
                        placeholder: "Surname", titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "First name", text: $model.driver.firstNameOfDriver,
                        placeholder: "Name", titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "Address", text: $model.driver.addressOfDriver,
                        placeholder: "Město, Ulice", titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "Driver's License Number",
                        text: $model.driver.driverLicenseNumber,
                        placeholder: "Driver's license number",
                        titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "Category", text: $model.driver.categoryOfLicense,
                        placeholder: "Category", titleColor: .accentColor)
                    TitledBorderTextField(
                        title: "Issued by", text: $model.driver.licenseIssuedBy,
                        placeholder: "Issued by", titleColor: .accentColor)
                }
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DriverView(model: DriverViewModel())
            .navigationTitle("Driver A")
    }
}
