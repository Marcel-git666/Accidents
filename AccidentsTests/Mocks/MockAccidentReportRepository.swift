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
    var fetchAllResult: Result<[AccidentReport], Error>?
    var saveResult: Result<Void, Error>?
    // Track the number of times saveReport was called
    var saveReportCalled = false
    var reports: [AccidentReport] = []
    var fetchAllCalled = false
    
    func save(_ report: AccidentReport, completion: @escaping (Error?) -> Void) {
        saveReportCalled = true
        if case let .failure(error) = saveResult { // Pattern match on .failure
            completion(error)
        } else {
            reports.append(report)
            completion(nil) // No error in saveResult
        }
    }
    
    func fetchAll(completion: @escaping ([AccidentReport], Error?) -> Void) {
        fetchAllCalled = true
        if let result = fetchAllResult {
            switch result {
            case .success(let reports):
                completion(reports, nil) // Access success value with .success
            case .failure(let error):
                completion([], error)
            }
        } else {
            completion([], nil) // No pre-defined result, return empty list without error
        }
    }
}

