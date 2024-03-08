//
//  AccidentLocationViewModel.swift
//  Accidents
//
//  Created by Marcel Mravec on 05.03.2024.
//

import SwiftUI

protocol AccidentLocationViewModelProtocol: ObservableObject {
    var accidentLocation: AccidentLocation { get set }
    func saveLocation(callback: @escaping LocationService.SaveLocationCallback)
}

class AccidentLocationViewModel: AccidentLocationViewModelProtocol {
    let locationService: LocationService
    
    @Published var accidentLocation: AccidentLocation = AccidentLocation( // Empty accidentLocation
        date: Date(),
        city: "",
        street: "",
        houseNumber: "",
        kilometerReading: 0.0
    )
    
    init(locationService: LocationService) {
        self.locationService = locationService
    }
    
    func saveLocation(callback: @escaping LocationService.SaveLocationCallback) {
        locationService.saveLocation(accidentLocation, callback: callback)
    }
    
    
}
