//
//  AccidentReportFillingState.swift
//  Accidents
//
//  Created by Marcel Mravec on 05.03.2024.
//

import SwiftUI

enum AccidentReportFillingState: Codable, Hashable {
    case accidentList
    case location
    case driver1
    case driver2
    case description
    case complete
}

