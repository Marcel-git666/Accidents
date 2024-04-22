//
//  RotationButtoView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.04.2024.
//

import SwiftUI

struct RotationButtoView: View {
    let vehicleManager: VehicleManager
    @Binding var selectedVehicle: Vehicle?
    
    var body: some View {
        VStack {
            Button(action: {
                if let selectedVehicle = selectedVehicle {
                    rotateClockwise(vehicle: selectedVehicle)
                }
            }) {
                Image(systemName: "arrow.clockwise")
                    .padding()
            }
            .disabled(selectedVehicle == nil)
            
            Button(action: {
                if let selectedVehicle = selectedVehicle {
                    rotateAntiClockwise(vehicle: selectedVehicle)
                }
            }) {
                Image(systemName: "arrow.counterclockwise")
                    .padding()
            }
            .disabled(selectedVehicle == nil)
        }
        .position(x: UIScreen.main.bounds.maxX - 50, y: UIScreen.main.bounds.midY - 120)
    }
    
    func rotateClockwise(vehicle: Vehicle) {
        guard let index = vehicleManager.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        vehicleManager.vehicles[index].rotationAngle += Angle.degrees(15)
    }
    
    func rotateAntiClockwise(vehicle: Vehicle) {
        guard let index = vehicleManager.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        vehicleManager.vehicles[index].rotationAngle -= Angle.degrees(15)
    }
    
}


struct RotationButtonView_previews: PreviewProvider {
    static var previews: some View {
        let vehicleManager = VehicleManager()
        let selectedVehicle = Binding<Vehicle?>(get: { return Vehicle(id: "1", location: .zero, imageName: "car", rotationAngle: .zero, scale: 1.0) }, set: { _ in })
        
        return RotationButtoView( vehicleManager: vehicleManager, selectedVehicle: selectedVehicle)
    }
}
