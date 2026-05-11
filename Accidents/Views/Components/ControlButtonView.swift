//
//  ControlButtonView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.04.2024.
//

import SwiftUI

struct ControlButtonView: View {
    @Binding var roadShape: RoadShapeSelector
    let model: SituationFormModel
    @Binding var selectedVehicle: Vehicle?

    var body: some View {
        VStack(spacing: 20) {
            Button {
                roadShape = .crossroad
            } label: {
                Image(systemName: "cross")
                    .foregroundColor(.black)
            }
            Button {
                roadShape = .normalRoad
            } label: {
                Image(systemName: "car.rear.road.lane")
                    .foregroundColor(.black)
            }
            Button {
                roadShape = .roundabout
            } label: {
                Image(systemName: "circle.circle")
                    .foregroundColor(.black)
            }
            HStack {
                Button {
                    model.vehicles.removeAll()
                } label: {
                    Image(systemName: "clear")
                        .foregroundColor(.black)
                }
                Button {
                    if let selectedVehicle = selectedVehicle {
                        model.removeVehicle(withId: selectedVehicle.id)
                        self.selectedVehicle = nil
                    }
                } label: {
                    Image(systemName: "selection.pin.in.out")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    ControlButtonView(
        roadShape: .constant(.crossroad),
        model: SituationFormModel(),
        selectedVehicle: .constant(nil))
}
