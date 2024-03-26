//
//  DescriptionView.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.03.2024.
//

import SwiftUI

struct DescriptionView: View {
    @ObservedObject var presenter: AccidentsPresenter
    
    let vehicleStatusDescription = [
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
                
                VisibleDamageView(notes1: $presenter.accidentDescription.notes1, notes2: $presenter.accidentDescription.notes2, color: .background)
                Text("Vehicle (Check all that apply)") // Centered title
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center) // Center alignment
                    .padding(.bottom)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(0..<vehicleStatusDescription.count) { index in
                            VehicleStatusView(vehicleStatusDescription: vehicleStatusDescription[index], isSelected1: $presenter.accidentDescription.vehicleDamage1[index], isSelected2: $presenter.accidentDescription.vehicleDamage2[index])
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.background)
                
                SaveButton(label: "Save Description", systemImage: "checkmark.circle") {
                    presenter.createReportAndSave()
                    presenter.goNext()
                }
            }
            .padding()
            .background(Color.background)
        }
    }
}

#Preview {
    DescriptionView(presenter: MockPresenter(repository: MockDataRepository()))
}

