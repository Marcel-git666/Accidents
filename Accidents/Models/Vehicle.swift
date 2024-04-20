//
//  Vehicle.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.04.2024.
//

import SwiftUI

struct Vehicle: Codable, Identifiable {
    let id: String
    var location: CGPoint
    let imageName: String
    var rotationAngle: Angle {
        get { Angle.degrees(rotatableObject.degrees) }
        set { rotatableObject.degrees = newValue.degrees }
    }
    private var rotatableObject: RotatableObject = RotatableObject(degrees: 0.0)
    var scale: CGFloat = 1.0
    
    init(id: String, location: CGPoint, imageName: String, rotationAngle: Angle, scale: CGFloat) {
        self.id = id
        self.location = location
        self.imageName = imageName
        self.rotationAngle = rotationAngle
        self.scale = scale
    }
    
    // Decoding initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let decodedId = try container.decode(String.self, forKey: .id)
        location = try container.decode(CGPoint.self, forKey: .location)
        imageName = try container.decode(String.self, forKey: .imageName)
        rotatableObject = try container.decode(RotatableObject.self, forKey: .rotationAngle)
        scale = try container.decode(CGFloat.self, forKey: .scale)
        self.id = decodedId // Assign decoded id to the constant property
    }
    
    // Encoding method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(location, forKey: .location)
        try container.encode(imageName, forKey: .imageName)
        try container.encode(rotatableObject, forKey: .rotationAngle) 
        try container.encode(scale, forKey: .scale)
    }
    
    enum CodingKeys: CodingKey {
        case id, location, imageName, rotationAngle, scale
    }
}


struct RotatableObject: Codable {
    var degrees: Double
}
