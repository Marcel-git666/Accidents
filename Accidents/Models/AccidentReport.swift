//
//  Accident.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI
import SwiftData

@Model
class AccidentReport {
    
    @Attribute(.unique) var id: UUID
    var accidentLocation: AccidentLocation
    var accidentDescription: AccidentDescription
    var pointOfImpact1: PointOfImpact?
    var pointOfImpact2: PointOfImpact?
    var accidentSituation: AccidentSituation?
    
    @Relationship(deleteRule: .cascade) var driver: Driver?
    @Relationship(deleteRule: .cascade) var otherDriver: Driver?
    
    init(
        id: UUID = UUID(),
        accidentLocation: AccidentLocation,
        driver: Driver? = nil,
        otherDriver: Driver? = nil,
        accidentDescription: AccidentDescription,
        pointOfImpact1: PointOfImpact? = nil,
        pointOfImpact2: PointOfImpact? = nil,
        accidentSituation: AccidentSituation? = nil
    ) {
        self.id = id
        self.accidentLocation = accidentLocation
        self.driver = driver
        self.otherDriver = otherDriver
        self.accidentDescription = accidentDescription
        self.pointOfImpact1 = pointOfImpact1
        self.pointOfImpact2 = pointOfImpact2
        self.accidentSituation = accidentSituation
    }
    
    
}
