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
}

enum AccidentReportNavigationState: String {
    case accidentList = "Reports"
    case start
}
