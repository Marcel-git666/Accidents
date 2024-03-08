//
//  AccidentReportCoordinator.swift
//  Accidents
//
//  Created by Marcel Mravec on 06.03.2024.
//

import SwiftUI

protocol AccidentReportCoordinatorProtocol: AnyObject {
    func getViewForState(_ state: AccidentReportFillingState) -> AnyView
    func proceedToDriver1()
    func proceedToDriver2()
    func saveReport()
    // Add other methods as needed
}

class AccidentReportCoordinator: ObservableObject, AccidentReportCoordinatorProtocol {
    @Published var state: AccidentReportFillingState = .location
    @Published var navPath = NavigationPath()
    @Published var accidentReports = [AccidentReport]()
    
    @Published var location: AccidentLocation? // Stores saved location
    @Published var driver1: Driver? // Stores saved driver 1 information
    @Published var driver2: Driver? // Stores saved driver 2 information
    
    private let accidentReportService: AccidentReportService
      private let locationService: LocationService
      private let driver1DataService: DriverDataService
      private let driver2DataService: DriverDataService

      init(accidentReportService: AccidentReportService,
           locationService: LocationService,
           driver1DataService: DriverDataService,
           driver2DataService: DriverDataService) {
        self.accidentReportService = accidentReportService
        self.locationService = locationService
        self.driver1DataService = driver1DataService
        self.driver2DataService = driver2DataService
      }
    
    func getViewForState(_ state: AccidentReportFillingState) -> AnyView {
        switch state {
        case .location:
            let viewModel = AccidentLocationViewModel(locationService: locationService)
                    return AnyView(AccidentLocationView(viewModel: viewModel, coordinator: self))
        case .driver1:
            let viewModel = DriverViewModel(driverDataService: driver1DataService)
            return AnyView(DriverView(viewModel: viewModel, driverType: .driver1, coordinator: self))
        case .driver2:
            let viewModel = DriverViewModel(driverDataService: driver2DataService)
            return AnyView(DriverView(viewModel: viewModel, driverType: .driver2, coordinator: self))
        case .accidentList:
            let viewModel = AccidentsViewModel(coordinator: self)
            return AnyView(AccidentsView(accidentsViewModel: viewModel))
            
        case .description:
            // not yet
            break
        case .complete:
            // not yet implemented
            break
        }
        let viewModel = AccidentsViewModel(coordinator: self)
        return AnyView(AccidentsView(accidentsViewModel: viewModel))
    }
    
    func startAccidentReporting() {
        state = .location
        navPath.append(state)
    }
    
    func proceedToDriver1() {
        
        state = .driver1
        navPath.append(state)
    }
    
    func proceedToDriver2() {
        // Optional: Access data from locationViewModel or driver1ViewModel
        // ... data processing and setup (if applicable)
        state = .driver2
        navPath.append(state)
    }
    
    // Callback passed to LocationService when saving location
    private func locationSavedCallback(_ location: AccidentLocation) {
        proceedToDriver1()
    }
                          
    // Triggered when saving location
    func saveLocation(_ location: AccidentLocation) {
                locationService.saveLocation(location, callback: locationSavedCallback)
    }
                           
    func driverDataSaved(driver: Driver, driverType: DriverType) {
      switch driverType {
      case .driver1:
        saveDriver1(driver)
      case .driver2:
        saveDriver2(driver)
      }
    }
    
    func saveDriver1(_ driver: Driver) {
        print("Driver1 info has been passed to coordinator")
        print(driver)
        
      // Store or process driver 1 information
      // ...
      proceedToDriver2()
    }

    func saveDriver2(_ driver: Driver) {
        print("Driver2 info has been passed to coordinator")
        print(driver)
        
        saveReport()
      // Store or process driver 2 information
      // ...
      // Proceed to next step (e.g., description of the accident)
    }
    
    func saveReport() {
        // Access data from all relevant view models and save the report
        // ... data processing and saving logic
        
        print(self.accidentReports)
        state = .accidentList // Return to accident list after saving
        navPath.removeLast(navPath.count)
    }
    
    func fetchAccidents() {
        //
      }
    
    func navigateBack() {
        switch state {
        case .driver2:
            state = .driver1
            navPath.removeLast()
        case .driver1:
            state = .location
            navPath.removeLast()
        case .location:
            navPath.removeLast()
            // Handle potential navigation back to the beginning (optional)
            break
        default:
            break
        }
    }
}
