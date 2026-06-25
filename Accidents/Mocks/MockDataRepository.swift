//
//  MockDataRepository.swift
//  Accidents
//
//  Created by Marcel Mravec on 20.03.2024.
//

import Foundation

struct MockDataRepository: AccidentReportRepository {
    var reports: [AccidentReport] = []
    
    func saveReport(_ report: AccidentReport) async throws { }
    func fetchAll() async throws -> [AccidentReport] { return reports }
    func removeReport(_ report: AccidentReport) async throws { }
    func updateReport(_ updatedReport: AccidentReport) async throws { }
}
