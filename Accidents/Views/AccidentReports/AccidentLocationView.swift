//
//  AccidentLocationView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentLocationView: View {
    @ObservedObject var presenter: AccidentsPresenter
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                               
                VStack(alignment: .leading) {
                    DatePicker("Date and Time", selection: $presenter.accidentLocation.date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                    
                    Text("Address")
                        .font(.headline)
                        .padding(.bottom)
                    
                    TextField("City", text: $presenter.accidentLocation.city)
                        .padding(.bottom)
                    
                    TextField("Street", text: $presenter.accidentLocation.street)
                        .padding(.bottom)
                    
                    TextField("House Number", text: $presenter.accidentLocation.houseNumber)
                        .padding(.bottom)
                    
                    Text("Kilometer Reading (optional)")
                        .font(.footnote)
                        .padding(.bottom)
                    
                    TextField("e.g., 12345.6", value: $presenter.accidentLocation.kilometerReading, format: .number)
                        .keyboardType(.decimalPad)
                        .padding(.bottom)
                    HStack(alignment: .center) {
                        YesNoView(question: "Injuries?", injury: $presenter.accidentLocation.injuries)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom)
                    }
                    Button(action: {
                        presenter.goNext()
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
//            .navigationTitle("\(presenter.viewState.rawValue)")
        }
    }
}

#Preview {
    NavigationView {
        AccidentLocationView(presenter: MockPresenter(repository: MockDataRepository()))
    }
}
