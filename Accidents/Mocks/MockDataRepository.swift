//
//  MockDataRepository.swift
//  Accidents
//
//  Created by Marcel Mravec on 20.03.2024.
//

import Foundation

struct MockDataRepository: AccidentReportRepository {
    func updateReport(_ updatedReport: AccidentReport) async throws {
        
    }
    
    var reports: [AccidentReport] = []
    
    func removeReport(_ report: AccidentReport) throws {
        // test
    }
    
  func fetchAll() throws -> [AccidentReport] {
       reports
  }
   
  func saveReport(_ report: AccidentReport) throws {
    // No-op for preview context
  }
}
