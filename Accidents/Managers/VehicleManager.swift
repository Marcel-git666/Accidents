//
//  SituationFormModel.swift
//  Accidents
//

import SwiftUI

@MainActor
@Observable
class SituationFormModel {
    var roadShape: RoadShapeSelector = .crossroad
    var vehicles: [Vehicle] = []

    func load(from situation: AccidentSituation) {
        roadShape = situation.roadShape
        vehicles = situation.vehicles
    }

    func reset() {
        roadShape = .crossroad
        vehicles = []
    }

    var accidentSituation: AccidentSituation {
        AccidentSituation(roadShape: roadShape, vehicles: vehicles)
    }

    func addBlueVehicle(location: CGPoint, imageName: String, rotationAngle: Angle, scale: Double) {
        if !vehicles.contains(where: { $0.imageName.contains("blue") }) {
            add(location: location, imageName: imageName, rotationAngle: rotationAngle, scale: scale)
        }
    }

    func addYellowVehicle(location: CGPoint, imageName: String, rotationAngle: Angle, scale: Double) {
        if !vehicles.contains(where: { $0.imageName.contains("yellow") }) {
            add(location: location, imageName: imageName, rotationAngle: rotationAngle, scale: scale)
        }
    }

    func addOtherVehicle(location: CGPoint, imageName: String, rotationAngle: Angle, scale: Double) {
        add(location: location, imageName: imageName, rotationAngle: rotationAngle, scale: scale)
    }

    private func add(location: CGPoint, imageName: String, rotationAngle: Angle, scale: Double) {
        vehicles.append(Vehicle(
            id: UUID().uuidString,
            location: location,
            imageName: imageName,
            rotationAngle: rotationAngle,
            scale: scale
        ))
    }

    func removeVehicle(withId id: String) {
        vehicles.removeAll { $0.id == id }
    }
}
