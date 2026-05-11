//
//  DriverFormModel.swift
//  Accidents
//

import SwiftUI

@MainActor
@Observable
class DriverFormModel {
    var driver: Driver

    init(_ driver: Driver = .sample1) {
        self.driver = driver
    }
}
