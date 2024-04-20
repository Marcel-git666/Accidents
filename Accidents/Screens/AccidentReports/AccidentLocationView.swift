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
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(LinearGradient(colors: [.blue, .accentColor], startPoint: .topLeading, endPoint: .top)))
                    
                    Text("Address")
                        .font(.headline)
                    
                    HStack {
                        TitledBorderTextField(title: "Street", text: $presenter.accidentLocation.street, placeholder: "Street", titleColor: .accentColor)
                        TitledBorderTextField(title: "House Number", text: $presenter.accidentLocation.houseNumber, placeholder: "House number", titleColor: .accentColor)
                    }
                    
                    HStack {
                        TitledBorderTextField(title: "City", text: $presenter.accidentLocation.city, placeholder: "Your city", titleColor: .accentColor)
                        
                        TitledBorderTextField(title: "Km Reading", text: $presenter.accidentLocation.kilometerReading, placeholder: "0", titleColor: .accentColor)
                            .keyboardType(.decimalPad)
                    }
                    
                    
                    HStack(alignment: .center) {
                        TickBox(text: "Injuries?", isSelected:  $presenter.accidentLocation.injuries)
                        
                    }
                    HStack(alignment: .center) {
                        TickBox(text: "Was police involved?", isSelected:  $presenter.accidentLocation.policeInvolved)
                    }
                    HStack(alignment: .center) {
                        TickBox(text: "Other damage than vehicle A and B?", isSelected:  $presenter.accidentLocation.otherDamage)
                    }
                    
                    Text("Witnesses")
                    
                    HStack(alignment: .top) {
                        VStack {
                            ForEach(presenter.accidentLocation.witnesses.indices, id: \.self) { index in
                                WitnessView(witness: $presenter.accidentLocation.witnesses[index])
                                    .padding(.bottom)
                            }
                        }
                        VStack(alignment: .leading) {
                            Button {
                                presenter.accidentLocation.witnesses.append(Witness(name: "", address: "", phoneNumber: ""))
                            } label: {
                                Label("Add", systemImage: "plus.circle")
                            }
                            .disabled(presenter.accidentLocation.witnesses.count >= 3)
                            Button {
                                presenter.accidentLocation.witnesses.removeLast()
                            } label: {
                                Label("Remove", systemImage: "minus.circle")
                            }
                            .disabled(presenter.accidentLocation.witnesses.isEmpty)
                        }
                    }
                }
                HStack {
                    ACButton(label: "Exit and save", systemImage: "checkmark.circle") {
                        presenter.createReportAndSave()
                    }
                    ACButton(label: "Save & Go next", systemImage: "goforward.plus") {
                        presenter.goNext()
                    }
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
