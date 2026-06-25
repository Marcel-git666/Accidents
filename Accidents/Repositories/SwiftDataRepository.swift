//
//  SwiftDataRepository.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.06.2026.
//


import SwiftData
import Foundation

@MainActor
class SwiftDataRepository: AccidentReportRepository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func saveReport(_ report: AccidentReport) async throws {
        context.insert(report)
        try context.save()
    }
    
    func fetchAll() async throws -> [AccidentReport] {
        let descriptor = FetchDescriptor<AccidentReport>()
        return try context.fetch(descriptor)
    }
    
    func removeReport(_ report: AccidentReport) async throws {
        context.delete(report)
        try context.save()
    }
    
    func updateReport(_ updatedReport: AccidentReport) async throws {
        try context.save()
    }
}
