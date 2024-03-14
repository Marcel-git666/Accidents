//
//  AccidentReportFillingState.swift
//  Accidents
//
//  Created by Marcel Mravec on 05.03.2024.
//

import SwiftUI

enum AccidentReportFillingState: String {
    case accidentList = "Reports"
    case location = "Location"
    case driver1 = "Driver 1"
    case driver2 = "Driver 2"
    case description = "Description"
    case complete
}
