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
        newAccidentLocationData.injuries = accidentLocation.injuries
        
        // Convert [Witness] array to NSSet of WitnessData
        if let witnesses = accidentLocation.witnesses {
            let witnessDataSet = NSMutableSet()
            for witness in witnesses {
                let witnessData = createWitnessData(from: witness)
                witnessDataSet.add(witnessData)
            }
            newAccidentLocationData.witnesses = witnessDataSet
        }
        newAccidentLocationData.otherDamage = accidentLocation.otherDamage ?? false
        newAccidentLocationData.policeInvolved = accidentLocation.policeInvolved ?? false
        
        return newAccidentLocationData
    }
    
    private func createWitnessData(from witness: Witness) -> WitnessData {
        let newWitnessData = NSEntityDescription.insertNewObject(forEntityName: K.witnessEntity, into: context) as! WitnessData
        
        newWitnessData.name = witness.name
        newWitnessData.address = witness.address
        newWitnessData.phoneNumber = witness.phoneNumber
        
        return newWitnessData
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
        
        newAccidentDescriptionData.notes1 = accidentDescription.notes1
        newAccidentDescriptionData.notes2 = accidentDescription.notes2
        
        let transformer = BoolArrayTransformer()
        newAccidentDescriptionData.vehicleDamage1 = transformer.transformedValue(accidentDescription.vehicleDamage1) as? NSData
        newAccidentDescriptionData.vehicleDamage2 = transformer.transformedValue(accidentDescription.vehicleDamage2) as? NSData

        return newAccidentDescriptionData
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
        let witnesses = fetchedReportData.accidentLocation?.witnesses?.allObjects as? [WitnessData] ?? []
        let witnessModels = witnesses.map { Witness(name: $0.name ?? "", address: $0.address ?? "", phoneNumber: $0.phoneNumber ?? "") }
        let vehicleDamageData1 = fetchedReportData.accidentDescription?.vehicleDamage1 as? Data ?? Data()
        let vehicleDamageData2 = fetchedReportData.accidentDescription?.vehicleDamage2 as? Data ?? Data()
        let boolArrayTransformer = BoolArrayTransformer()
        let vehicleDamage1 = boolArrayTransformer.reverseTransformedValue(vehicleDamageData1) as? [Bool] ?? []
        let vehicleDamage2 = boolArrayTransformer.reverseTransformedValue(vehicleDamageData2) as? [Bool] ?? []
        
        
        return AccidentReport(
            id: fetchedReportData.idReport!,
            accidentLocation: AccidentLocation(
                date: fetchedReportData.accidentLocation?.date ?? Date(),
                city: fetchedReportData.accidentLocation?.city! ?? "",
                street: fetchedReportData.accidentLocation?.street! ?? "",
                houseNumber: fetchedReportData.accidentLocation?.houseNumber! ?? "",
                kilometerReading: fetchedReportData.accidentLocation?.kilometerReading,
                injuries: fetchedReportData.accidentLocation?.injuries ?? false,
                witnesses: witnessModels,
                otherDamage: fetchedReportData.accidentLocation?.otherDamage ?? false,
                policeInvolved: fetchedReportData.accidentLocation?.policeInvolved ?? false
            ),
            driver: driver ?? Driver(name: "", address: "", phoneNumber: "", driverLicenseNumber: "", vehicleRegistrationPlate: "", insuranceCompany: "", insurancePolicyNumber: ""),
            otherDriver: otherDriver ?? Driver(name: "", address: "", phoneNumber: "", driverLicenseNumber: "", vehicleRegistrationPlate: "", insuranceCompany: "", insurancePolicyNumber: ""),
            accidentDescription: AccidentDescription(
                notes1: fetchedReportData.accidentDescription!.notes1!,
                notes2: fetchedReportData.accidentDescription!.notes2!,
                vehicleDamage1: vehicleDamage1,
                vehicleDamage2: vehicleDamage2
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
    
    func updateReport(_ updatedReport: AccidentReport) async throws {
        let fetchRequest: NSFetchRequest<AccidentReportData> = NSFetchRequest(entityName: K.reportEntity)
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(AccidentReportData.idReport), updatedReport.id])
        
        do {
            let fetchedReports = try context.fetch(fetchRequest)
            guard let reportToUpdate = fetchedReports.first else {
                throw CoreDataError.failedToFindReportToUpdate
            }

            // Update Core Data objects for AccidentLocation, Driver, OtherDriver, AccidentDescription
            reportToUpdate.accidentLocation = createAccidentLocationData(from: updatedReport.accidentLocation)
            reportToUpdate.driver = createDriverData(from: updatedReport.driver)
            if let otherDriver = updatedReport.otherDriver {
              reportToUpdate.otherDriver = createDriverData(from: otherDriver)
            } else {
              // Handle case where otherDriver is nil (optional)
              reportToUpdate.otherDriver = nil // Or create a default driver object
            }
            reportToUpdate.accidentDescription = createAccidentDescriptionData(from: updatedReport.accidentDescription)
            reportToUpdate.idReport = updatedReport.id

            try context.save()
        } catch {
           throw CoreDataError.coreDataUpdateError
        }
    }
}
