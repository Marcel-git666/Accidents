//
//  DriverFormModel.swift
//  Accidents
//

import SwiftUI

@MainActor
@Observable
class DriverViewModel {
    var driver: Driver

    init(_ driver: Driver = Driver()) {
        self.driver = driver
    }
}
