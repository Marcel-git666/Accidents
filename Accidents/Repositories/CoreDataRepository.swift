//
//  CoreDataRepository.swift
//  Accidents
//
//  Created by Marcel Mravec on 15.03.2024.
//

import CoreData

class CoreDataRepository: AccidentReportRepository {
    private let context: NSManagedObjectContext
    
    init() {
        self.context = CoreDataManager.shared.viewContext()
    }
    
    func createAccidentReportData(from report: AccidentReport) -> AccidentReportData {
        guard let reportEntity = NSEntityDescription.entity(forEntityName: Constants.reportEntity, in: context) else {
            fatalError("Failed to find entity description for AccidentReportData")
        }
        
        let newReportData = AccidentReportData(entity: reportEntity, insertInto: context)
        
        do {
            let reportData = try JSONEncoder().encode(report)
            newReportData.reportData = reportData
            newReportData.idReport = report.id
        } catch {
            print("Error encoding accident report data:", error)
        }
        
        return newReportData
    }
    
    func saveReport(_ report: AccidentReport) async throws {
        let newReportData = createAccidentReportData(from: report)
        do {
            context.insert(newReportData)
            try context.save()
        } catch {
            throw CoreDataError.coreDataSaveError
        }
    }
    
    func fetchAll() async throws -> [AccidentReport] {
      let fetchRequest: NSFetchRequest<AccidentReportData> = NSFetchRequest(entityName: Constants.reportEntity)

      do {
        let fetchedReports = try context.fetch(fetchRequest)
        let reports = try fetchedReports.compactMap { try convertFromCoreData(fetchedReportData: $0) }
        return reports
      } catch {
        if let coreDataError = error as? CoreDataError {
          switch coreDataError {
          case .decodingError:
            print("Error decoding accident reports:", coreDataError.localizedDescription)
            throw coreDataError
          default:
            throw coreDataError
          }
        } else {
          // Handle other errors
        }
      }
        return []
    }
    
    func removeReport(_ report: AccidentReport) async throws {
        let fetchRequest: NSFetchRequest<AccidentReportData> = NSFetchRequest(entityName: Constants.reportEntity)
        
        // Add a predicate to filter based on report properties 
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(AccidentReportData.idReport), report.id])
        do {
            let fetchedReports = try context.fetch(fetchRequest)
            
            guard let reportToDelete = fetchedReports.first else {
                throw CoreDataError.coreDataRemoveError
            }
            context.delete(reportToDelete)
            try context.save()
            
        } catch {
            throw CoreDataError.coreDataRemoveError
        }
    }
    
    func updateReport(_ updatedReport: AccidentReport) async throws {
        let fetchRequest: NSFetchRequest<AccidentReportData> = NSFetchRequest(entityName: Constants.reportEntity)
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(AccidentReportData.idReport), updatedReport.id])
        
        do {
            let fetchedReports = try context.fetch(fetchRequest)
            guard let reportToUpdate = fetchedReports.first else {
                throw CoreDataError.failedToFindReportToUpdate
            }
            
            do {
                let reportData = try JSONEncoder().encode(updatedReport)
                reportToUpdate.reportData = reportData
            } catch {
                print("Error encoding updated accident report data:", error)
            }
            
            try context.save()
        } catch {
            throw CoreDataError.coreDataUpdateError
        }
    }
    
    private func convertFromCoreData(fetchedReportData: AccidentReportData) throws -> AccidentReport? {
        guard let reportData = fetchedReportData.reportData else {
            print("Error: reportData is nil")
            return nil
        }
        
        do {
            let report = try JSONDecoder().decode(AccidentReport.self, from: reportData)
            return report
        } catch {
            print("Error decoding accident report data:", error)
            throw CoreDataError.decodingError
        }
    }
}
