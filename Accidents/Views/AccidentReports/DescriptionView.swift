//
//  DescriptionView.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.03.2024.
//

import SwiftUI

struct DescriptionView: View {
  @ObservedObject var presenter: AccidentsPresenter

  let damageDescriptions = [
    "Parked",
    "Starting to move",
    "Stopping",
    "Exiting parking lot/private property/dirt road",
    "Turning into parking lot/private property/dirt road",
    "Entering roundabout",
    "Driving in roundabout",
    "Rear-ended while driving in the same direction and lane",
    "Driving alongside in another lane",
    "Changing lanes",
    "Overtaking",
    "Turning right",
    "Turning left",
    "Reversing",
    "Driving in the opposite direction",
    "Approaching from the right",
    "Failed to yield right of way"
  ]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Accident Description")
                    .font(.headline)
                    .padding(.bottom)
                
                TextField("Notes (part 1)", text: $presenter.accidentDescription.notes1)
                    .padding(.bottom)
                
                TextField("Notes (part 2)", text: $presenter.accidentDescription.notes2)
                    .padding(.bottom)
                
                Text("Vehicle Damage (Check all that apply)") // Centered title
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center) // Center alignment
                    .padding(.bottom)
                
                ScrollView {
                    VStack(alignment: .leading) { // Nested VStack for spacing
                        ForEach(0..<damageDescriptions.count) { index in
                            HStack {
                                TickBox(text: damageDescriptions[index], isSelected: $presenter.accidentDescription.vehicleDamage1[index], frameColor: .clear)
                                Spacer()
                                TickBox(text: damageDescriptions[index], isSelected: $presenter.accidentDescription.vehicleDamage2[index], frameColor: .clear)
                            }
                        }
                    }
                }

                Button(action: {
                    presenter.createReportAndSave()
                    presenter.goNext()
                }) {
          Label("Save Description", systemImage: "checkmark.circle")
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold))
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(.black)
            .cornerRadius(15)
        }
      }
      .padding()
      .navigationTitle("\(presenter.viewState.rawValue)")
    }
  }
}

#Preview {
    DescriptionView(presenter: MockPresenter(repository: MockDataRepository()))
}
