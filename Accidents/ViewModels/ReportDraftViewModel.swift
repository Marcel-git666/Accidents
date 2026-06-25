//
//  ReportDraftViewModel.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.06.2026.
//


import SwiftUI

@MainActor
@Observable
class ReportDraftViewModel {
    var location = LocationViewModel()
    var driverA = DriverViewModel()
    var driverB = DriverViewModel()
    var description = DescriptionViewModel()
    var impactA = ImpactViewModel()
    var impactB = ImpactViewModel()
    var situation = SituationViewModel()
    
    var originalReport: AccidentReport?

    func load(from report: AccidentReport) {
        originalReport = report
        
        location.location = report.accidentLocation
        driverA.driver = report.driver ?? Driver()
        driverB.driver = report.otherDriver ?? Driver()
        description.accidentDescription = report.accidentDescription
        impactA.load(report.pointOfImpact1 ?? .defaultValue)
        impactB.load(report.pointOfImpact2 ?? .defaultValue)
        situation.load(from: report.accidentSituation ?? AccidentSituation(roadShape: .crossroad))
    }

    func reset() {
        originalReport = nil
        
        location.location = .defaultValue
        driverA.driver = Driver()
        driverB.driver = Driver()
        description.accidentDescription = .defaultValue
        impactA.reset()
        impactB.reset()
        situation.reset()
    }


    func createOrUpdateReport() -> AccidentReport {
        if let report = originalReport {
            report.accidentLocation = location.location
            report.driver = driverA.driver
            report.otherDriver = driverB.driver
            report.accidentDescription = description.accidentDescription
            report.pointOfImpact1 = impactA.pointOfImpact
            report.pointOfImpact2 = impactB.pointOfImpact
            report.accidentSituation = situation.accidentSituation
            return report
        } else {
            return AccidentReport(
                id: UUID(),
                accidentLocation: location.location,
                driver: driverA.driver,
                otherDriver: driverB.driver,
                accidentDescription: description.accidentDescription,
                pointOfImpact1: impactA.pointOfImpact,
                pointOfImpact2: impactB.pointOfImpact,
                accidentSituation: situation.accidentSituation
            )
        }
    }
}
