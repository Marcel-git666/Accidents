//
//  RotationButtoView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.04.2024.
//

import SwiftUI

struct RotationButtoView: View {
    let model: SituationViewModel
    @Binding var selectedVehicle: Vehicle?
    
    var body: some View {
        VStack {
            Button(action: {
                if let selectedVehicle = selectedVehicle {
                    rotateClockwise(vehicle: selectedVehicle)
                }
            }, label: {
                Image(systemName: "arrow.clockwise")
                    .padding()
            })
            .disabled(selectedVehicle == nil)
            
            Button(action: {
                if let selectedVehicle = selectedVehicle {
                    rotateAntiClockwise(vehicle: selectedVehicle)
                }
            }, label: {
                Image(systemName: "arrow.counterclockwise")
                    .padding()
            })
            .disabled(selectedVehicle == nil)
        }
        .position(x: UIScreen.main.bounds.maxX - 50, y: UIScreen.main.bounds.midY - 120)
    }
    
    func rotateClockwise(vehicle: Vehicle) {
        guard let index = model.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        model.vehicles[index].rotationAngle += Angle.degrees(15)
    }
    
    func rotateAntiClockwise(vehicle: Vehicle) {
        guard let index = model.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        model.vehicles[index].rotationAngle -= Angle.degrees(15)
    }
    
}

#Preview {
    RotationButtoView(model: SituationViewModel(), selectedVehicle: .constant(nil))
}
