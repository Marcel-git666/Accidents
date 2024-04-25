//
//  MockAccidentReportRepository.swift
//  AccidentsTests
//
//  Created by Marcel Mravec on 18.03.2024.
//

import Foundation

@testable import Accidents

class MockAccidentReportRepository: AccidentReportRepository {

    var savedReport: AccidentReport?
    var updatedReport: AccidentReport?
    var fetchedReports: [AccidentReport] = []
    var removedReport: AccidentReport?
    var fetchError: Error?
    var saveError: Error?
    var removeError: Error?
    var updateError: Error?

    func saveReport(_ report: AccidentReport) async throws {
        if let error = saveError {
            throw error
        }
        savedReport = report
    }

    func fetchAll() async throws -> [AccidentReport] {
        if let error = fetchError {
            throw error
        }
        return fetchedReports
    }

    func removeReport(_ report: AccidentReport) async throws {
        if let error = removeError {
            throw error
        }
        removedReport = report
    }

    func updateReport(_ updatedReport: Accidents.AccidentReport) async throws {
        if let error = updateError {
            throw error
        }
        self.updatedReport = updatedReport
        // Optionally, you can update the fetchedReports array to simulate the update
        if let index = fetchedReports.firstIndex(where: { $0.id == updatedReport.id }) {
            fetchedReports[index] = updatedReport
        }
    }
}
