//
//  AccidentLocationView.swift
//  Accidents
//

import SwiftUI

struct AccidentLocationView: View {
    @Bindable var model: LocationFormModel

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ScrollView {
                    DatePicker("Date and Time", selection: $model.location.date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(LinearGradient(colors: [.blue, .accentColor], startPoint: .topLeading, endPoint: .top)))

                    Text("Address")
                        .font(.headline)

                    HStack {
                        TitledBorderTextField(
                            title: "Street",
                            text: $model.location.street,
                            placeholder: "Street", titleColor: .accentColor)
                        TitledBorderTextField(
                            title: "House Number", text: $model.location.houseNumber,
                            placeholder: "House number", titleColor: .accentColor)
                    }

                    HStack {
                        TitledBorderTextField(
                            title: "City", text: $model.location.city,
                            placeholder: "Your city", titleColor: .accentColor)
                        TitledBorderTextField(
                            title: "Km Reading", text: $model.location.kilometerReading,
                            placeholder: "0", titleColor: .accentColor)
                            .keyboardType(.decimalPad)
                    }

                    HStack(alignment: .center) {
                        TickBox(text: "Injuries?",
                                isSelected: $model.location.injuries)
                    }
                    HStack(alignment: .center) {
                        TickBox(text: "Was police involved?",
                                isSelected: $model.location.policeInvolved)
                    }
                    HStack(alignment: .center) {
                        TickBox(text: "Other damage than vehicle A and B?", isSelected: $model.location.otherDamage)
                    }

                    Text("Witnesses")

                    HStack(alignment: .top) {
                        VStack {
                            ForEach(model.location.witnesses.indices, id: \.self) { index in
                                WitnessView(witness: $model.location.witnesses[index])
                                    .padding(.bottom)
                            }
                        }
                        VStack(alignment: .leading) {
                            Button {
                                model.location.witnesses.append(Witness(name: "", address: "", phoneNumber: ""))
                            } label: {
                                Label("Add", systemImage: "plus.circle")
                            }
                            .disabled(model.location.witnesses.count >= 3)
                            Button {
                                model.location.witnesses.removeLast()
                            } label: {
                                Label("Remove", systemImage: "minus.circle")
                            }
                            .disabled(model.location.witnesses.isEmpty)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    NavigationView {
        AccidentLocationView(model: LocationFormModel())
    }
}
