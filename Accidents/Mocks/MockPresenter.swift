//
//  MockPresenter.swift
//  Accidents
//
//  Created by Marcel Mravec on 20.03.2024.
//

import Foundation

class MockPresenter: AccidentsPresenter {
    init(repository: MockDataRepository) {
        super.init(repository: repository)
        self.errorMessage = "Optional error message"
        self.accidentReports = [AccidentReport.sampleData]
    }
}
