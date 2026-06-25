//
//  AccidentSituation.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.06.2026.
//

import SwiftUI

struct AccidentSituation: Codable {
    var roadShape: RoadShapeSelector
    var vehicles: [Vehicle]

    init(roadShape: RoadShapeSelector, vehicles: [Vehicle] = []) {
        self.roadShape = roadShape
        self.vehicles = vehicles
    }

    // Migrate data saved in the old three-field format
    private enum CodingKeys: String, CodingKey {
        case roadShape, vehicles
        case blueVehicle, yellowVehicle, otherVehicles
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        roadShape = try c.decode(RoadShapeSelector.self, forKey: .roadShape)
        if let v = try? c.decode([Vehicle].self, forKey: .vehicles) {
            vehicles = v
        } else {
            var migrated: [Vehicle] = []
            if let blue = try? c.decodeIfPresent(Vehicle.self, forKey: .blueVehicle) { migrated += [blue].compactMap { $0 } }
            if let yellow = try? c.decodeIfPresent(Vehicle.self, forKey: .yellowVehicle) { migrated += [yellow].compactMap { $0 } }
            migrated += (try? c.decode([Vehicle].self, forKey: .otherVehicles)) ?? []
            vehicles = migrated
        }
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(roadShape, forKey: .roadShape)
        try c.encode(vehicles, forKey: .vehicles)
    }
}
