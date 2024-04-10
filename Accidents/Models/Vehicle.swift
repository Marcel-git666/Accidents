//
//  Vehicle.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.04.2024.
//

import SwiftUI

struct Vehicle: Identifiable {
    let id: String = UUID().uuidString
    var location: CGPoint
    let imageName: String
    var rotationAngle: Angle = .degrees(0)
    var scale: CGFloat = 1.0
}
