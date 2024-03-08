//
//  DriverView.swift
//  Accidents
//
//  Created by Marcel Mravec on 05.03.2024.
//

import SwiftUI

struct DriverView: View {
    @ObservedObject var viewModel: DriverViewModel
    let driverType: DriverType
    let coordinator: AccidentReportCoordinatorProtocol
        
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Driver \(driverType == .driver1 ? "1" : "2") Information")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                VStack(alignment: .leading) {
                    TextField("Full Name", text: $viewModel.accidentDriver.name)
                        .padding(.bottom)
                    
                    TextField("Address", text: $viewModel.accidentDriver.address)
                        .padding(.bottom)
                    
                    TextField("Driver's License Number", text: $viewModel.accidentDriver.driverLicenseNumber)
                        .padding(.bottom)
                    
                    TextField("Phone Number", text: $viewModel.accidentDriver.phoneNumber)
                        .keyboardType(.phonePad)
                        .padding(.bottom)
                    
                    TextField("Vehicle Registration Plate", text: $viewModel.accidentDriver.vehicleRegistrationPlate)
                        .padding(.bottom)
                    
                    TextField("Insurance Company", text: $viewModel.accidentDriver.insuranceCompany)
                        .padding(.bottom)
                    
                    TextField("Insurance Policy Number", text: $viewModel.accidentDriver.insurancePolicyNumber)
                        .padding(.bottom)
                    
                    Button(action: {
                        viewModel.saveDriver(driverType: driverType) { updatedDriver in
                            // Handle the updated driver if needed
                            // For example, you can print the updated driver:
                            print("Driver saved:", updatedDriver)
                            driverType == .driver1 ? coordinator.proceedToDriver2() : coordinator.saveReport()
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

private class MockAccidentReportCoordinator: AccidentReportCoordinator {
    
}
private class MockDriverDataService: DriverDataServiceProtocol {
    func saveDriver(_ driver: Driver, callback: @escaping SaveDriverCallback) {
        print("Saved...")
    }
    
    
}

//#Preview {
//    let driverDataService: MockDriverDataService
//    return DriverView(viewModel: DriverViewModel(driverDataService: driverDataService), driverType: .driver2)
//}
