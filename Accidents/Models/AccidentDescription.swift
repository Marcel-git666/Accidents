//
//  AccidentDescription.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.06.2026.
//

import SwiftUI

struct AccidentDescription: Codable {
    var notes1: String
    var notes2: String
    var vehicleDamage1: [Bool]
    var vehicleDamage2: [Bool]
}

extension AccidentDescription {
    static let defaultValue = AccidentDescription(
        notes1: "", notes2: "",
        vehicleDamage1: Array(repeating: false, count: 17),
        vehicleDamage2: Array(repeating: false, count: 17)
    )
}
