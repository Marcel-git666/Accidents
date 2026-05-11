//
//  DescriptionView.swift
//  Accidents
//

import SwiftUI

struct DescriptionView: View {
    @Bindable var model: DescriptionFormModel

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
        VStack {
            VStack(alignment: .leading) {
                VisibleDamageView(
                    notes1: $model.accidentDescription.notes1,
                    notes2: $model.accidentDescription.notes2,
                    color: .background)
                Text("Vehicle (Check all that apply)")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom)
            }
            ScrollView {
                ForEach(vehicleStatusDescription.indices, id: \.self) { index in
                    VehicleStatusView(
                        vehicleStatusDescription: vehicleStatusDescription[index],
                        isSelected1: $model.accidentDescription.vehicleDamage1[index],
                        isSelected2: $model.accidentDescription.vehicleDamage2[index])
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.background)
        }
        .padding()
        .background(Color.background)
    }
}

#Preview {
    DescriptionView(model: DescriptionFormModel())
}
