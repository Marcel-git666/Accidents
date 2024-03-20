//
//  AccidentsPresenterTests.swift
//  AccidentsTests
//
//  Created by Marcel Mravec on 18.03.2024.
//

import XCTest
@testable import Accidents

final class AccidentsPresenterTests: XCTestCase {
    
    private var mockRepository: MockAccidentReportRepository!
    private var sut: AccidentsPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepository = MockAccidentReportRepository()
        sut = AccidentsPresenter(repository: mockRepository)
    }
    
    func test_givenEmptyReports_whenFetchAccidents_thenFetchesAndUpdates() {
        // Given
        mockRepository.fetchAllResult = .success([])
        
        // When
        sut.fetchAccidents()
        
        // Then
        XCTAssertEqual(sut.accidentReports.count, 0)
        XCTAssertTrue(mockRepository.fetchAllCalled)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isErrorPresented)
    }
    
    func test_givenSampleReport_whenFetchAccidents_thenFetchesAndUpdates() {
        // Given
        mockRepository.fetchAllResult = .success([AccidentReport.sampleData])
        
        // When
        sut.fetchAccidents()
        
        // Then
        XCTAssertEqual(sut.accidentReports.count, 1)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isErrorPresented)
    }
    
    func test_givenFetchError_whenFetchAccidents_thenHandlesError() {
        // Given
        mockRepository.fetchAllResult = .failure(CoreDataError.coreDataFetchError)
        
        // When
        sut.fetchAccidents()
        
        // Then
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(sut.errorMessage, "There was an error fetching your data from your device.")
        XCTAssertTrue(sut.isErrorPresented)
    }
    
    func test_givenValidReportData_whenSaveReport_thenSavesAndUpdates() {
        // Given
        let location = AccidentLocation(date: Date(), city: "Brno", street: "Main Street", houseNumber: "12", kilometerReading: 100.0)
        let driver1 = Driver(name: "John Doe", address: "10 Downing St", phoneNumber: "+44 20 7903 3900", driverLicenseNumber: "A123456", vehicleRegistrationPlate: "ABC 123", insuranceCompany: "Acme Insurance", insurancePolicyNumber: "1234567890")
        let driver2 = Driver(name: "Jane Smith", address: "221B Baker St", phoneNumber: "+44 20 7224 3688", driverLicenseNumber: "B987654", vehicleRegistrationPlate: "DEF 456", insuranceCompany: "Global Insurance", insurancePolicyNumber: "0987654321")
        let description = AccidentDescription(accidentDescription: "Car accident at an intersection", vehicleDamage: "Minor damage to front bumper")
        sut.accidentLocation = location
        sut.accidentDriver1 = driver1
        sut.accidentDriver2 = driver2
        sut.accidentDescription = description
        mockRepository.saveResult = .success(Void())
        
        // When
        sut.saveReport()
        
        // Then
        let expectedReport = AccidentReport(accidentLocation: location, driver: driver1, otherDriver: driver2, accidentDescription: description)
        XCTAssertTrue(mockRepository.saveReportCalled)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isErrorPresented)
    }
    
    func test_givenEmptyData_whenSaveReport_thenFailsAndShowsError() {
        // Given
        mockRepository.saveResult = .failure(CoreDataError.coreDataSaveError)
        
        // When
        sut.saveReport()
        
        // Then
        XCTAssertEqual(mockRepository.reports, [])
        XCTAssertNotNil(sut.errorMessage) // You might want to check the specific error message if needed
        XCTAssertTrue(sut.isErrorPresented)
    }
    
    func test_givenSaveError_whenSaveReport_thenHandlesError() {
        // Given
        let location = AccidentLocation(date: Date(), city: "Brno", street: "Main Street", houseNumber: "12", kilometerReading: 100.0)
        let driver1 = Driver(name: "John Doe", address: "10 Downing St", phoneNumber: "+44 20 7903 3900", driverLicenseNumber: "A123456", vehicleRegistrationPlate: "ABC 123", insuranceCompany: "Acme Insurance", insurancePolicyNumber: "1234567890")
        let driver2 = Driver(name: "Jane Smith", address: "221B Baker St", phoneNumber: "+44 20 7224 3688", driverLicenseNumber: "B987654", vehicleRegistrationPlate: "DEF 456", insuranceCompany: "Global Insurance", insurancePolicyNumber: "0987654321")
        let description = AccidentDescription(accidentDescription: "Car accident at an intersection", vehicleDamage: "Minor damage to front bumper")
        sut.accidentLocation = location
        sut.accidentDriver1 = driver1
        sut.accidentDriver2 = driver2
        sut.accidentDescription = description
        mockRepository.saveResult = .failure(CoreDataError.coreDataSaveError)
        
        // When
        sut.saveReport()
        
        // Then
        XCTAssertEqual(mockRepository.reports, [])
        XCTAssertEqual(sut.errorMessage, "There was an error saving your data to your device.") 
        XCTAssertTrue(sut.isErrorPresented)
    }
    
    func test_givenExistingReport_whenRemoveReport_thenRemovesAndUpdates() {
        // Given
        let existingReport = AccidentReport.sampleData
        mockRepository.reports = [existingReport]
        sut.accidentReports = [existingReport]
    
        
        // When
        sut.removeReport(existingReport)
        
        
        // Then
    
        XCTAssertFalse(mockRepository.removeReportCalled)
        XCTAssertEqual(mockRepository.reports, [])
        XCTAssertEqual(sut.accidentReports, [])
    }

    
}
