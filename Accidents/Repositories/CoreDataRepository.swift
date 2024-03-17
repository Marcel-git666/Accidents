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
    
    func save(_ report: AccidentReport, completion: @escaping (Error?) -> Void) {
        let newReport = NSEntityDescription.insertNewObject(forEntityName: "AccidentReportData", into: context) as! AccidentReportData
        
        let newLocation = NSEntityDescription.insertNewObject(forEntityName: "AccidentLocationData", into: context) as! AccidentLocationData
        newLocation.date = report.accidentLocation.date // Assuming optional unwrapping or handling
        newLocation.city = report.accidentLocation.city
        newLocation.street = report.accidentLocation.street
        newLocation.houseNumber = report.accidentLocation.houseNumber
        newLocation.kilometerReading = report.accidentLocation.kilometerReading!
        
        newReport.accidentLocation = newLocation
        
        let newDriverData = NSEntityDescription.insertNewObject(forEntityName: "DriverData", into: context) as! DriverData
        newDriverData.name = report.driver.name
        newDriverData.address = report.driver.address
        newDriverData.phoneNumber = report.driver.phoneNumber
        newDriverData.driverLicenseNumber = report.driver.driverLicenseNumber
        newDriverData.vehicleRegistrationPlate = report.driver.vehicleRegistrationPlate
        newDriverData.insuranceCompany = report.driver.insuranceCompany
        newDriverData.insurancePolicyNumber = report.driver.insurancePolicyNumber
        newDriverData.isAtFault = report.driver.isAtFault ?? false
        
        newReport.driver = newDriverData
        
        if let otherDriver = report.otherDriver {
            let newOtherDriverData = NSEntityDescription.insertNewObject(forEntityName: "DriverData", into: context) as! DriverData
            newOtherDriverData.name = otherDriver.name
            newOtherDriverData.address = otherDriver.address
            newOtherDriverData.phoneNumber = otherDriver.phoneNumber // typo fixed here (was newDriverData)
            newOtherDriverData.driverLicenseNumber = otherDriver.driverLicenseNumber
            newOtherDriverData.vehicleRegistrationPlate = otherDriver.vehicleRegistrationPlate
            newOtherDriverData.insuranceCompany = otherDriver.insuranceCompany
            newOtherDriverData.insurancePolicyNumber = otherDriver.insurancePolicyNumber
            newOtherDriverData.isAtFault = otherDriver.isAtFault ?? false
            
            newReport.otherDriver = newOtherDriverData
        }
        
        let newDescriptionData = NSEntityDescription.insertNewObject(forEntityName: "AccidentDescriptionData", into: context) as! AccidentDescriptionData
        newDescriptionData.accidentDescription = report.accidentDescription.accidentDescription
        newDescriptionData.vehicleDamage = report.accidentDescription.vehicleDamage
        newDescriptionData.injuries = report.accidentDescription.injuries
        
        newReport.accidentDescription = newDescriptionData
        
        do {
            try context.save()
            completion(nil)
        } catch {
            completion(CoreDataError.coreDataSaveError)
        }
    }
    
    
    func fetchAll(completion: @escaping ([AccidentReport], Error?) -> Void) {
        let fetchRequest: NSFetchRequest<AccidentReportData> = NSFetchRequest(entityName: "AccidentReportData")
        
        do {
            let fetchedReports = try context.fetch(fetchRequest)
            let reports = fetchedReports.map { fetchedReport in
                var driver: Driver?
                var otherDriver: Driver?
                
                if let driverData = fetchedReport.driver {
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
                
                if let otherDriverData = fetchedReport.otherDriver {
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
                    accidentLocation: AccidentLocation(
                        date: fetchedReport.accidentLocation?.date! ?? Date(),
                        city: fetchedReport.accidentLocation?.city! ?? "",
                        street: fetchedReport.accidentLocation?.street! ?? "",
                        houseNumber: fetchedReport.accidentLocation?.houseNumber! ?? "",
                        kilometerReading: fetchedReport.accidentLocation?.kilometerReading
                    ),
                    driver: driver ?? Driver(name: "", address: "", phoneNumber: "", driverLicenseNumber: "", vehicleRegistrationPlate: "", insuranceCompany: "", insurancePolicyNumber: ""),
                    otherDriver: otherDriver ?? Driver(name: "", address: "", phoneNumber: "", driverLicenseNumber: "", vehicleRegistrationPlate: "", insuranceCompany: "", insurancePolicyNumber: ""),
                    accidentDescription: AccidentDescription(
                        accidentDescription: fetchedReport.accidentDescription!.accidentDescription!,
                        vehicleDamage: fetchedReport.accidentDescription!.vehicleDamage!,
                        injuries: fetchedReport.accidentDescription!.injuries
                    )
                )
            }
            completion(reports, nil)
        } catch {
            completion([], CoreDataError.coreDataFetchError)
        }
    }
}
