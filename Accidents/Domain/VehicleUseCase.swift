//
//  VehicleUseCase.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.04.2024.
//

import Foundation

protocol VehicleUseCase {
  func addVehicle(location: CGPoint, imageName: String)
  func removeVehicle(withId id: String)
}
