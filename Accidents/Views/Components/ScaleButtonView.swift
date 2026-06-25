//
//  ScaleButtonView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.04.2024.
//

import SwiftUI

struct ScaleButtonView: View {
    let model: SituationViewModel
    @Binding var selectedVehicle: Vehicle?

    var body: some View {
        VStack {
            Button(action: {
                if let selectedVehicle = selectedVehicle {
                    scaleUp(vehicle: selectedVehicle)
                }
            }, label: {
                Image(systemName: "plus")
                    .padding()
            })
            .disabled(selectedVehicle == nil)

            Button(action: {
                if let selectedVehicle = selectedVehicle {
                    scaleDown(vehicle: selectedVehicle)
                }
            }, label: {
                Image(systemName: "minus")
                    .padding()
            })
            .disabled(selectedVehicle == nil)
        }
        .position(x: 50, y: UIScreen.main.bounds.midY - 120)
    }

    func scaleUp(vehicle: Vehicle) {
        guard let index = model.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        model.vehicles[index].scale *= 1.1
    }

    func scaleDown(vehicle: Vehicle) {
        guard let index = model.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        model.vehicles[index].scale *= 0.9
    }
}

#Preview {
    ScaleButtonView(model: SituationViewModel(), selectedVehicle: .constant(nil))
}
