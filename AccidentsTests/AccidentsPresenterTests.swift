//
//  AccidentsPresenterTests.swift
//  AccidentsTests
//
//  Created by Marcel Mravec on 18.03.2024.
//

import XCTest
@testable import Accidents

final class AccidentsPresenterTests: XCTestCase {
    
    private var mockRepository: MockAccidentReportRepository!
    private var sut: AccidentsPresenter!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepository = MockAccidentReportRepository()
        sut = AccidentsPresenter(repository: mockRepository)
    }
    
    func test_givenFetchError_whenFetchAccidents_thenHandlesError() async {
        // Given
        mockRepository.fetchError = CoreDataError.coreDataFetchError
        let expectation = expectation(description: "Error should be handled")
            
        // When
        await sut.fetchAccidents()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.sut.errorMessage)
            XCTAssertEqual(self.sut.errorMessage, CoreDataError.coreDataFetchError.rawValue)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1.0, enforceOrder: false)
    }
    
    func test_givenNoError_whenFetchAccidents_thenAccidentsFetchedSuccessfully() async {
        // Given
        mockRepository.fetchError = nil
        mockRepository.fetchedReports.append(AccidentReport.sampleData)
        let expectation = expectation(description: "AccidentReport should be fetched")
        
        // When
        await sut.fetchAccidents()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(self.sut.errorMessage)
            XCTAssertEqual(self.sut.accidentReports.count, 1)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1.0, enforceOrder: false)
    }
    
    func test_givenValidReportData_whenSaveReport_thenSavesAndUpdates() async {
        // Given
        let reportToSave = AccidentReport.sampleData
        mockRepository.saveError = nil
        let expectation = expectation(description: "AccidentReport should be saved")
        
        // When
        await sut.saveReport(reportToSave)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.mockRepository.savedReport, self.sut.accidentReports.last)
            XCTAssertNil(self.sut.errorMessage)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1.0, enforceOrder: false)
    }
    
    func test_givenSaveError_whenSaveReport_thenHandlesError() async {
        // Given
        mockRepository.saveError = CoreDataError.coreDataSaveError
        let reportToSave = AccidentReport.sampleData
        let expectation = expectation(description: "Save error should be handled")
        
        // When
        await sut.saveReport(reportToSave)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.sut.errorMessage)
            XCTAssertEqual(self.sut.errorMessage, "There was an error saving your data to your device.")
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0, enforceOrder: false)
    }
    
    func test_givenExistingReport_whenRemoveReport_thenRemovesAndUpdates() async {
        // Given
        let existingReport = AccidentReport.sampleData
        await sut.saveReport(existingReport)
        mockRepository.removeError = nil
        let expectation = expectation(description: "Report should be removed")
        // When
        await sut.removeReport(existingReport)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockRepository.removedReport == existingReport)
            XCTAssertEqual(self.sut.accidentReports.count, 0)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1.0, enforceOrder: false)
    }
}
