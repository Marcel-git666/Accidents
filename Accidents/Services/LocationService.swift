//
//  LocationService.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.03.2024.
//

import Foundation

class LocationService {
    
    typealias SaveLocationCallback = (AccidentLocation) -> Void
    
    func saveLocation(_ location: AccidentLocation, callback: @escaping SaveLocationCallback) {
        print("Location has been passed to coordinator")
        print(location)
        callback(location)
    }
}
