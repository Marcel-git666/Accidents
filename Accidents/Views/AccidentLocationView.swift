//
//  AccidentLocationView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentLocationView<ViewModel: AccidentLocationViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    let coordinator: AccidentReportCoordinatorProtocol
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Accident Location")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                VStack(alignment: .leading) {
                    DatePicker("Date and Time", selection: $viewModel.accidentLocation.date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                    
                    Text("Address")
                        .font(.headline)
                        .padding(.bottom)
                    
                    TextField("City", text: $viewModel.accidentLocation.city)
                        .padding(.bottom)
                    
                    TextField("Street", text: $viewModel.accidentLocation.street)
                        .padding(.bottom)
                    
                    TextField("House Number", text: $viewModel.accidentLocation.houseNumber)
                        .padding(.bottom)
                    
                    Text("Kilometer Reading (optional)")
                        .font(.footnote)
                        .padding(.bottom)
                    
                    TextField("e.g., 12345.6", value: $viewModel.accidentLocation.kilometerReading, format: .number)
                        .keyboardType(.decimalPad)
                        .padding(.bottom)
                    
                    Button(action: {
                        viewModel.saveLocation { location in
                                // Handle the location callback if needed
                                // For example, you can print the location:
                                print("Location saved in view:", location)
                            coordinator.proceedToDriver1()
                            }
                        
                    }) {
                        Label("Save Location", systemImage: "checkmark.circle")
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

//#Preview {
//    var coordinator = AccidentReportCoordinator()
//    coordinator.accidentLocation = AccidentLocation(date: Date.now, city: "Brno", street: "nam. Svobody", houseNumber: "2a", kilometerReading: nil)
//    return AccidentLocationView(viewModel: viewModel)
//}
