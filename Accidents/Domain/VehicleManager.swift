//
//  DefaultVehicleUseCase.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.04.2024.
//

import Foundation

class VehicleManager: ObservableObject, VehicleUseCase {
  @Published var vehicles: [Vehicle] = []

  func addVehicle(location: CGPoint, imageName: String) {
      vehicles.append(Vehicle(id: UUID().uuidString, location: location, imageName: imageName, rotationAngle: .zero, scale: 1.0))
  }

  func removeVehicle(withId id: String) {
    vehicles.removeAll { vehicle in
      vehicle.id == id
    }
  }
}
