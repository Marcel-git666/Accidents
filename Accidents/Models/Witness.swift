//
//  Witness.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.06.2026.
//

import SwiftUI

struct Witness: Codable, Hashable {
    var name: String
    var address: String
    var phoneNumber: String
    
    static let sample = Witness(name: "Rabi Lowe", address: "Poland", phoneNumber: "456789456")
}
