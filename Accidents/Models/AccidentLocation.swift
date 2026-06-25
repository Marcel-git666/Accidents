//
//  AccidentLocation.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.06.2026.
//

import SwiftUI

struct AccidentLocation: Codable {
    var date: Date
    var city: String
    var street: String
    var houseNumber: String
    var kilometerReading: String
    var injuries: Bool
    var witnesses: [Witness]
    var otherDamage: Bool
    var policeInvolved: Bool
}

extension AccidentLocation {
    static let defaultValue = AccidentLocation(
        date: Date(), city: "", street: "", houseNumber: "",
        kilometerReading: "0.0", injuries: false, witnesses: [],
        otherDamage: false, policeInvolved: false
    )
}
