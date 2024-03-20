//
//  MockDataRepository.swift
//  Accidents
//
//  Created by Marcel Mravec on 20.03.2024.
//

import Foundation

struct MockDataRepository: AccidentReportRepository {
    func removeReport(_ report: AccidentReport, completion: @escaping (Result<Void, any Error>) -> Void) {
        // test
    }
    
  func fetchAll(completion: @escaping ([AccidentReport], (any Error)?) -> Void) {
    completion(([AccidentReport.sampleData]), (any Error)?.self as? Error)
  }
   
  func save(_ report: AccidentReport, completion: @escaping (Error?) -> Void) {
    // No-op for preview context
    completion(nil)
  }
}
