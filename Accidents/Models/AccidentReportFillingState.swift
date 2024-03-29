//
//  AccidentReportFillingState.swift
//  Accidents
//
//  Created by Marcel Mravec on 05.03.2024.
//

import SwiftUI

enum AccidentReportFillingState: String {
    case location = "Location"
    case driver1 = "Driver A"
    case driver2 = "Driver B"
    case description = "Description"
    case pointOfImpact1 = "Crash Point A"
    case pointOfImpact2 = "Crash Point B"
    
    static let allCases: [AccidentReportFillingState] = [.location, .driver1, .driver2, .description, .pointOfImpact1, .pointOfImpact2]
}
