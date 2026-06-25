//
//  MockCoordinator.swift
//  Accidents
//

import SwiftUI

@MainActor
@Observable
class MockCoordinator: AccidentsCoordinating {
    var viewState: AccidentReportNavigationState = .accidentList
    var selectedTab: AccidentReportFillingState = .location
    var accidentReports: [AccidentReport] = [PreviewData.accidentReport]
    var errorMessage: String? = "Optional error message"
    var reportToPreview: AccidentReport?
    let draft = ReportDraftViewModel()

    func goNext() {}
    func goBack() {}
    func handleSelectedTab(_ tab: AccidentReportFillingState) {}
    func editReport(_ report: AccidentReport) {}
    func exitAndSaveReport() {}
    func exitWithoutSaving() {}
    func removeReport(_ report: AccidentReport) {}
    func fetchAccidents() async {}
    func exportPDF(for report: AccidentReport) {}
    func showReportPreview(for report: AccidentReport) {}
    func closeReportPreview() {}
}
