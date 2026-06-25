//
//  PointOfImpact.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.06.2026.
//

import SwiftUI

struct PointOfImpact: Codable {
    var x: Double
    var y: Double
    var arrowRotation: Double
    var scale: CGFloat
    
    var crashPoint: CGPoint {
        get { CGPoint(x: x, y: y) }
        set {
            x = Double(newValue.x)
            y = Double(newValue.y)
        }
    }
}

extension PointOfImpact {
    static let defaultValue = PointOfImpact(
        x: 200,
        y: 100,
        arrowRotation: 0,
        scale: 1
    )
}
