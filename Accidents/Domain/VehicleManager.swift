//
//  DefaultVehicleUseCase.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.04.2024.
//

import Foundation

class VehicleManager: ObservableObject {
    @Published var vehicles: [Vehicle] = []
    
    func addBlueVehicle(location: CGPoint, imageName: String) {
        if let existingBlueVehicleIndex = vehicles.firstIndex(where: { $0.imageName.contains("blue") }) {
            // If a blue vehicle already exists, update its location
            vehicles[existingBlueVehicleIndex].location = location
        } else {
            // Add a new blue vehicle
            addVehicle(location: location, imageName: imageName)
        }
    }
    
    func addYellowVehicle(location: CGPoint, imageName: String) {
        if let existingYellowVehicleIndex = vehicles.firstIndex(where: { $0.imageName.contains("yellow") }) {
            // If a yellow vehicle already exists, update its location
            vehicles[existingYellowVehicleIndex].location = location
        } else {
            // Add a new yellow vehicle
            addVehicle(location: location, imageName: imageName)
        }
    }
    
    func addOtherVehicle(location: CGPoint, imageName: String) {
        addVehicle(location: location, imageName: imageName)
    }
    
    private func addVehicle(location: CGPoint, imageName: String) {
        vehicles.append(Vehicle(id: UUID().uuidString, location: location, imageName: imageName, rotationAngle: .zero, scale: 1.0))
    }
    
    func removeVehicle(withId id: String) {
        vehicles.removeAll { vehicle in
            vehicle.id == id
        }
    }
}
