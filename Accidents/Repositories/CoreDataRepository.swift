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
        let newReportData = NSEntityDescription.insertNewObject(forEntityName: K.reportEntity, into: context) as! AccidentReportData
        
        // Populate AccidentReportData properties using AccidentReport data
        newReportData.accidentLocation = createAccidentLocationData(from: report.accidentLocation)
        newReportData.driver = createDriverData(from: report.driver)
        newReportData.otherDriver = report.otherDriver.map { createDriverData(from: $0) }
        newReportData.accidentDescription = createAccidentDescriptionData(from: report.accidentDescription)
        newReportData.idReport = report.id
        return newReportData
    }
    
    // Helper methods for creating related Core Data objects
    private func createAccidentLocationData(from accidentLocation: AccidentLocation) -> AccidentLocationData {
        let newAccidentLocationData = NSEntityDescription.insertNewObject(forEntityName: K.locationEntity, into: context) as! AccidentLocationData
        
        newAccidentLocationData.date = accidentLocation.date
        newAccidentLocationData.city = accidentLocation.city
        newAccidentLocationData.street = accidentLocation.street
        newAccidentLocationData.houseNumber = accidentLocation.houseNumber
        newAccidentLocationData.kilometerReading = accidentLocation.kilometerReading ?? 0
        
        return newAccidentLocationData
    }
    
    private func createDriverData(from driver: Driver) -> DriverData {
        let newDriverData = NSEntityDescription.insertNewObject(forEntityName: K.driverEntity, into: context) as! DriverData
        
        newDriverData.name = driver.name
        newDriverData.address = driver.address
        newDriverData.phoneNumber = driver.phoneNumber
        newDriverData.driverLicenseNumber = driver.driverLicenseNumber
        newDriverData.vehicleRegistrationPlate = driver.vehicleRegistrationPlate
        newDriverData.insuranceCompany = driver.insuranceCompany
        newDriverData.insurancePolicyNumber = driver.insurancePolicyNumber
        newDriverData.isAtFault = driver.isAtFault ?? false
        
        return newDriverData
    }
    
    private func createAccidentDescriptionData(from accidentDescription: AccidentDescription) -> AccidentDescriptionData {
        let newAccidentDescriptionData = NSEntityDescription.insertNewObject(forEntityName: K.descriptionEntity, into: context) as! AccidentDescriptionData
        
        newAccidentDescriptionData.accidentDescription = accidentDescription.accidentDescription
        newAccidentDescriptionData.vehicleDamage = accidentDescription.vehicleDamage
        newAccidentDescriptionData.injuries = accidentDescription.injuries
        
        return newAccidentDescriptionData
    }
    
    func save(_ report: AccidentReport) async throws {
        let newReportData = createAccidentReportData(from: report)
        do {
            context.insert(newReportData)
            try context.save()
        } catch {
            throw CoreDataError.coreDataSaveError
        }
    }
    
    
    func fetchAll() async throws -> [AccidentReport] {
        let fetchRequest: NSFetchRequest<AccidentReportData> = NSFetchRequest(entityName: K.reportEntity)
        
        do {
            let fetchedReports = try context.fetch(fetchRequest)
            let reports = fetchedReports.map { fetchedReportData in
                // Convert Core Data object to AccidentReport
                return convertFromCoreData(fetchedReportData: fetchedReportData)
            }
            return reports
        } catch {
            throw CoreDataError.coreDataFetchError
        }
    }

    // Helper method to convert from Core Data object to AccidentReport
    private func convertFromCoreData(fetchedReportData: AccidentReportData) -> AccidentReport {
      var driver: Driver?
      var otherDriver: Driver?
      
      if let driverData = fetchedReportData.driver {
        driver = Driver(
          name: driverData.name!,
          address: driverData.address!,
          phoneNumber: driverData.phoneNumber!,
          driverLicenseNumber: driverData.driverLicenseNumber!,
          vehicleRegistrationPlate: driverData.vehicleRegistrationPlate!,
          insuranceCompany: driverData.insuranceCompany!,
          insurancePolicyNumber: driverData.insurancePolicyNumber!,
          isAtFault: driverData.isAtFault
        )
      }
      
      if let otherDriverData = fetchedReportData.otherDriver {
        otherDriver = Driver(
          name: otherDriverData.name!,
          address: otherDriverData.address!,
          phoneNumber: otherDriverData.phoneNumber!,
          driverLicenseNumber: otherDriverData.driverLicenseNumber!,
          vehicleRegistrationPlate: otherDriverData.vehicleRegistrationPlate!,
          insuranceCompany: otherDriverData.insuranceCompany!,
          insurancePolicyNumber: otherDriverData.insurancePolicyNumber!,
          isAtFault: otherDriverData.isAtFault
        )
      }
      
      return AccidentReport(
        id: fetchedReportData.idReport!,
        accidentLocation: AccidentLocation(
          date: fetchedReportData.accidentLocation?.date ?? Date(),
          city: fetchedReportData.accidentLocation?.city! ?? "",
          street: fetchedReportData.accidentLocation?.street! ?? "",
          houseNumber: fetchedReportData.accidentLocation?.houseNumber! ?? "",
          kilometerReading: fetchedReportData.accidentLocation?.kilometerReading
        ),
        driver: driver ?? Driver(name: "", address: "", phoneNumber: "", driverLicenseNumber: "", vehicleRegistrationPlate: "", insuranceCompany: "", insurancePolicyNumber: ""),
        otherDriver: otherDriver ?? Driver(name: "", address: "", phoneNumber: "", driverLicenseNumber: "", vehicleRegistrationPlate: "", insuranceCompany: "", insurancePolicyNumber: ""),
        accidentDescription: AccidentDescription(
          accidentDescription: fetchedReportData.accidentDescription!.accidentDescription!,
          vehicleDamage: fetchedReportData.accidentDescription!.vehicleDamage!,
          injuries: fetchedReportData.accidentDescription!.injuries
        )
      )
    }
    
    func removeReport(_ report: AccidentReport) async throws {
      let fetchRequest: NSFetchRequest<AccidentReportData> = NSFetchRequest(entityName: K.reportEntity)

      // Add a predicate to filter based on report properties (assuming unique identifier)
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

}
