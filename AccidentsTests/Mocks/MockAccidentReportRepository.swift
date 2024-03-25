//
//  MockAccidentReportRepository.swift
//  AccidentsTests
//
//  Created by Marcel Mravec on 18.03.2024.
//

import Foundation

@testable import Accidents

class MockAccidentReportRepository: AccidentReportRepository {
  
    // Store mock data or behavior
    var savedReport: AccidentReport?
    var fetchedReports: [AccidentReport] = []
    var removedReport: AccidentReport?
    var fetchError: Error?
    var saveError: Error?
    var removeError: Error?

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
        
    }
}
