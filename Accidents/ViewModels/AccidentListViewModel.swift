//
//  AccidentListViewModel.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import Foundation

class AccidentListViewModel: ObservableObject {
    @Published var accidentReports: [AccidentReport] = []

    func fetchAccidents() {
        print("Fetching accidents from source....")
    }
}
