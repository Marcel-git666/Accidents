//
//  Vehicle.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.04.2024.
//

import SwiftUI

struct Vehicle: Codable, Identifiable {
    let id: String
    var x: Double
    var y: Double
    let imageName: String
    var rotationAngle: Angle {
        get { Angle.degrees(rotatableObject.degrees) }
        set { rotatableObject.degrees = newValue.degrees }
    }
    private var rotatableObject: RotatableObject = RotatableObject(degrees: 0.0)
    var scale: CGFloat = 1.0
    
    var location: CGPoint {
        get { CGPoint(x: x, y: y) }
        set {
            x = Double(newValue.x)
            y = Double(newValue.y)
        }
    }
    
    init(id: String, location: CGPoint, imageName: String, rotationAngle: Angle, scale: CGFloat) {
        self.id = id
        self.x = Double(location.x)
        self.y = Double(location.y)
        self.imageName = imageName
        self.rotationAngle = rotationAngle
        self.scale = scale
    }
    
    enum CodingKeys: CodingKey {
        case id, x, y, imageName, rotationAngle, scale
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.x = try container.decode(Double.self, forKey: .x)
        self.y = try container.decode(Double.self, forKey: .y)
        self.imageName = try container.decode(String.self, forKey: .imageName)
        self.rotatableObject = try container.decode(RotatableObject.self, forKey: .rotationAngle)
        self.scale = try container.decode(CGFloat.self, forKey: .scale)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(imageName, forKey: .imageName)
        try container.encode(rotatableObject, forKey: .rotationAngle)
        try container.encode(scale, forKey: .scale)
    }
}

struct RotatableObject: Codable {
    var degrees: Double
}
