//
//  ImpactFormModel.swift
//  Accidents
//

import SwiftUI

@MainActor
@Observable
class ImpactFormModel {
    var crashPoint: CGPoint = CGPoint(x: 200, y: 100)
    var arrowRotation: Double = 0
    var scale: CGFloat = 1

    func load(_ impact: PointOfImpact) {
        crashPoint = impact.crashPoint
        arrowRotation = impact.arrowRotation
        scale = impact.scale
    }

    func reset() {
        crashPoint = CGPoint(x: 200, y: 100)
        arrowRotation = 0
        scale = 1
    }

    var pointOfImpact: PointOfImpact {
        PointOfImpact(
            x: Double(crashPoint.x),
            y: Double(crashPoint.y),
            arrowRotation: arrowRotation,
            scale: scale
        )
    }
}
