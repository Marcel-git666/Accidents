//
//  DriverDataService.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.03.2024.
//

import Foundation

protocol DriverDataServiceProtocol {
    typealias SaveDriverCallback = (Driver) -> Void
    func saveDriver(_ driver: Driver, callback: @escaping SaveDriverCallback)
}

class DriverDataService: DriverDataServiceProtocol {
    func saveDriver(_ driver: Driver, callback: @escaping SaveDriverCallback) {
        print("Driver data saved...")
        print(driver)
        callback(driver)
    }
}
