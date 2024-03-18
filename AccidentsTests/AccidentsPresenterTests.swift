//
//  AccidentsPresenterTests.swift
//  AccidentsTests
//
//  Created by Marcel Mravec on 18.03.2024.
//

import XCTest
@testable import Accidents

final class AccidentsPresenterTests: XCTestCase {

    func testFetchAccidents_success() {
        // Set up mocks
        let mockRepository = MockAccidentReportRepository()
        mockRepository.fetchAllResult = .success([AccidentReport.sampleData])
        let presenter = AccidentsPresenter(repository: mockRepository)

        
        // Execute fetchAccidents
        presenter.fetchAccidents()
        
        // Assert expectations
        XCTAssertEqual(presenter.accidentReports.count, 1)
        XCTAssertNil(presenter.errorMessage)
        XCTAssertFalse(presenter.isErrorPresented)
    }

}
