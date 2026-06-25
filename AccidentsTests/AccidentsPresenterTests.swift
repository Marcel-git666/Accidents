//
//  AccidentsPresenterTests.swift
//  AccidentsTests
//
//  Created by Marcel Mravec on 18.03.2024.
//

import XCTest
@testable import Accidents

@MainActor
final class AccidentsPresenterTests: XCTestCase {

    private var mockRepository: MockAccidentReportRepository!
    private var sut: AccidentsCoordinator!

    // Moderní asynchronní setUp nahrazuje starý setUpWithError
    override func setUp() async throws {
        mockRepository = MockAccidentReportRepository()
        sut = AccidentsCoordinator(repository: mockRepository)
    }

    func test_givenFetchError_whenFetchAccidents_thenHandlesError() async throws {
        // Given
        mockRepository.fetchError = StorageError.fetchError

        // When
        await sut.fetchAccidents()

        // Then
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(sut.errorMessage, StorageError.fetchError.localizedDescription)
    }

    func test_givenNoError_whenFetchAccidents_thenAccidentsFetchedSuccessfully() async throws {
        // Given
        mockRepository.fetchError = nil
        mockRepository.fetchedReports.append(PreviewData.accidentReport)

        // When
        await sut.fetchAccidents()

        // Then
        XCTAssertNil(sut.errorMessage)
        XCTAssertEqual(sut.accidentReports.count, 1)
    }

    func test_createReportAndSave_whenNewReport_thenSavesReport() async throws {
        // Given
        mockRepository.saveError = nil
        sut.draft.load(from: PreviewData.accidentReport)
        sut.draft.originalReport = nil // Vynutíme, aby to Coordinator bral jako novou nehodu

        // When
        sut.createReportAndSave() // Spustí Task na pozadí
        try await Task.sleep(nanoseconds: 100_000_000) // Počkáme 0.1s, než Task doběhne

        // Then
        XCTAssertNotNil(mockRepository.savedReport)
    }

    func test_createReportAndSave_whenExistingReport_thenUpdatesReport() async throws {
        // Given
        let existingReport = PreviewData.accidentReport
        mockRepository.fetchedReports.append(existingReport)
        await sut.fetchAccidents()

        // Načteme do draftu a změníme jméno
        sut.draft.load(from: existingReport)
        sut.draft.driverA.driver.insuredName = "Updated Name"
        mockRepository.updateError = nil

        // When
        sut.createReportAndSave()
        try await Task.sleep(nanoseconds: 100_000_000)

        // Then
        XCTAssertEqual(mockRepository.updatedReport?.driver?.insuredName, "Updated Name")
    }

    func test_givenExistingReport_whenRemoveReport_thenRemovesAndUpdates() async throws {
        // Given
        let existingReport = PreviewData.accidentReport
        mockRepository.fetchedReports = [existingReport]
        await sut.fetchAccidents()
        mockRepository.removeError = nil
        
        // When
        sut.removeReport(existingReport)
        try await Task.sleep(nanoseconds: 100_000_000)

        // Then
        XCTAssertEqual(mockRepository.removedReport?.id, existingReport.id)
        XCTAssertEqual(sut.accidentReports.count, 0)
    }

    func test_goNext_whenInAccidentListState_thenTransitionsToStartStateAndLocationTab() {
        // Given
        sut.viewState = .accidentList

        // When
        sut.goNext()

        // Then
        XCTAssertEqual(sut.viewState, .start)
        XCTAssertEqual(sut.selectedTab, .location)
    }
}
