//
//  DriverFormModel.swift
//  Accidents
//

import SwiftUI

@MainActor
@Observable
class DriverFormModel {
    var driver: Driver

    init(_ driver: Driver = Driver()) {
        self.driver = driver
    }
}
