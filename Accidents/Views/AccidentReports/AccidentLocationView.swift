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
                               
                ScrollView {
                    DatePicker("Date and Time", selection: $presenter.accidentLocation.date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                    
                    Text("Address")
                        .font(.headline)
                    
                    TitledBorderTextField(title: "City", text: $presenter.accidentLocation.city, placeholder: "Your city", titleColor: .accentColor)
                    
                    
                    TitledBorderTextField(title: "Street", text: $presenter.accidentLocation.street, placeholder: "Street", titleColor: .accentColor)
                    
                    TitledBorderTextField(title: "House Number", text: $presenter.accidentLocation.houseNumber, placeholder: "House number", titleColor: .accentColor)
                    
                    TitledBorderTextField(title: "Kilometer Reading (optional)", text: $presenter.accidentLocation.kilometerReading, placeholder: "0", titleColor: .accentColor)
                        .keyboardType(.decimalPad)
                    
                    HStack(alignment: .center) {
                        YesNoView(question: "Injuries?", injury: $presenter.accidentLocation.injuries)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom)
                    }
                }
                    SaveButton(label: "Save Location", systemImage: "checkmark.circle") {
                        presenter.goNext()
                    }
                    
                }
                .padding()
        }
    }
}

#Preview {
    NavigationView {
        AccidentLocationView(presenter: MockPresenter(repository: MockDataRepository()))
    }
}
