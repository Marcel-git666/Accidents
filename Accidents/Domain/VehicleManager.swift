//
//  DefaultVehicleUseCase.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.04.2024.
//

import SwiftUI

class VehicleManager: ObservableObject {
    @Published var vehicles: [Vehicle] = []
    
    func addBlueVehicle(location: CGPoint, imageName: String, rotationAngle: Angle, scale: Double) {
        if !vehicles.contains(where: { $0.imageName.contains("blue") }) {
            addVehicle(location: location, imageName: imageName, rotationAngle: rotationAngle, scale: scale)
        }
    }
    
    func addYellowVehicle(location: CGPoint, imageName: String, rotationAngle: Angle, scale: Double) {
        if !vehicles.contains(where: { $0.imageName.contains("yellow") }) {
            addVehicle(location: location, imageName: imageName, rotationAngle: rotationAngle, scale: scale)
        }
    }
    
    func addOtherVehicle(location: CGPoint, imageName: String, rotationAngle: Angle, scale: Double) {
        addVehicle(location: location, imageName: imageName, rotationAngle: rotationAngle, scale: scale)
    }
    
    private func addVehicle(location: CGPoint, imageName: String, rotationAngle: Angle, scale: Double) {
        vehicles.append(Vehicle(id: UUID().uuidString, location: location, imageName: imageName, rotationAngle: rotationAngle, scale: scale))
    }
    
    func removeVehicle(withId id: String) {
        vehicles.removeAll { vehicle in
            vehicle.id == id
        }
    }
}
