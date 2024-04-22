//
//  ScaleButtonView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.04.2024.
//

import SwiftUI

struct ScaleButtonView: View {
    let vehicleManager: VehicleManager
    @Binding var selectedVehicle: Vehicle?
    
    var body: some View {
        VStack {
            Button(action: {
                if let selectedVehicle = selectedVehicle {
                    scaleUp(vehicle: selectedVehicle)
                }
            }) {
                Image(systemName: "plus")
                    .padding()
            }
            .disabled(selectedVehicle == nil)
            
            Button(action: {
                if let selectedVehicle = selectedVehicle {
                    scaleDown(vehicle: selectedVehicle)
                }
            }) {
                Image(systemName: "minus")
                    .padding()
            }
            .disabled(selectedVehicle == nil)
        }
        .position(x: 50, y: UIScreen.main.bounds.midY - 120)
    }
    
    func scaleUp(vehicle: Vehicle) {
        guard let index = vehicleManager.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        vehicleManager.vehicles[index].scale *= 1.1
    }
    
    func scaleDown(vehicle: Vehicle) {
        guard let index = vehicleManager.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        vehicleManager.vehicles[index].scale *= 0.9
    }
}

struct ScaleButtonView_previews: PreviewProvider {
    static var previews: some View {
        let vehicleManager = VehicleManager()
        let selectedVehicle = Binding<Vehicle?>(get: { return Vehicle(id: "1", location: .zero, imageName: "car", rotationAngle: .zero, scale: 1.0) }, set: { _ in })
        
        return ScaleButtonView(vehicleManager: vehicleManager, selectedVehicle: selectedVehicle)
    }
}
