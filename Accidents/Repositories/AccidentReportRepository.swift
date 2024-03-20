//
//  AccidentReportRepository.swift
//  Accidents
//
//  Created by Marcel Mravec on 15.03.2024.
//

protocol AccidentReportRepository {
    func save(_ report: AccidentReport, completion: @escaping (Error?) -> Void)
    func fetchAll(completion: @escaping ([AccidentReport], Error?) -> Void)
    func removeReport(_ report: AccidentReport, completion: @escaping (Result<Void, Error>) -> Void)
}
