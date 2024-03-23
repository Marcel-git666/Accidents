//
//  AccidentReportRepository.swift
//  Accidents
//
//  Created by Marcel Mravec on 15.03.2024.
//

protocol AccidentReportRepository {
    func saveReport(_ report: AccidentReport) async throws
    func fetchAll() async throws -> [AccidentReport]
    func removeReport(_ report: AccidentReport) async throws
    func updateReport(_ updatedReport: AccidentReport) async throws
}
