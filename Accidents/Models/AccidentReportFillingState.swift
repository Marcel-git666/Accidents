//
//  AccidentReportFillingState.swift
//  Accidents
//
//  Created by Marcel Mravec on 05.03.2024.
//

import SwiftUI

enum AccidentReportFillingState: String, Identifiable {
    case location = "Location"
    case driver1 = "Driver A"
    case driver2 = "Driver B"
    case description = "Description"
    case pointOfImpact1 = "Crash Point A"
    case pointOfImpact2 = "Crash Point B"
    case mapView
    
    static let allCases: [AccidentReportFillingState] = [.location, .driver1, .driver2, .description, .pointOfImpact1, .pointOfImpact2, .mapView]
    var id: String { rawValue }
    var systemImageName: String {
        switch self {
        case .location:
          return "mappin"
        case .driver1, .driver2:
          return "person.fill"
        case .description:
          return "pencil.and.ruler.fill"
        case .pointOfImpact1, .pointOfImpact2:
          return "car.top.radiowaves.rear.left.fill"
        case .mapView:
            return "map"
        }
      }
}
