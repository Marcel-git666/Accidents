//
//  AccidentListViewModel.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

class AccidentsViewModel: ObservableObject {
    let coordinator: AccidentReportCoordinator
    @Published var accidentReports: [AccidentReport] = []

    init(coordinator: AccidentReportCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchAccidents() {
        print("Fetching accidents from source....")
        accidentReports = coordinator.accidentReports
    }
    
    func startAccidentReporting() {
        coordinator.startAccidentReporting()
    }
}
