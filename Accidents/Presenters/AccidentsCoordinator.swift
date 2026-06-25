//
//  AccidentsCoordinator.swift
//  Accidents
//

import SwiftUI

import SwiftUI

// MARK: - Protocol

@MainActor
protocol AccidentsCoordinating: AnyObject, Observable {
    var viewState: AccidentReportNavigationState { get set }
    var selectedTab: AccidentReportFillingState { get set }
    var accidentReports: [AccidentReport] { get }
    var errorMessage: String? { get }
    var reportToPreview: AccidentReport? { get set }
    var draft: ReportDraftViewModel { get }
    
    func goNext()
    func goBack()
    func handleSelectedTab(_ tab: AccidentReportFillingState)
    func editReport(_ report: AccidentReport)
    func exitAndSaveReport()
    func exitWithoutSaving()
    func removeReport(_ report: AccidentReport)
    func fetchAccidents() async
    func exportPDF(for report: AccidentReport)
    func showReportPreview(for report: AccidentReport)
    func closeReportPreview()
}

// MARK: - Implementation

@MainActor
@Observable
class AccidentsCoordinator: AccidentsCoordinating {
    private let repository: AccidentReportRepository
    
    // Navigation
    var viewState: AccidentReportNavigationState = .accidentList
    var selectedTab: AccidentReportFillingState = .location
    @ObservationIgnored var transitionEffect: AnyTransition = .scale
    
    // Report list & State
    var accidentReports: [AccidentReport] = []
    var errorMessage: String?
    var reportToPreview: AccidentReport?
    
    let draft = ReportDraftViewModel()
    
    init(repository: AccidentReportRepository) {
        self.repository = repository
        setUp()
    }
    
    private func setUp() {
        Task { await fetchAccidents() }
    }
    
    func fetchAccidents() async {
        do {
            accidentReports = try await repository.fetchAll()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func handleSelectedTab(_ tab: AccidentReportFillingState) {
        withAnimation { selectedTab = tab }
    }
    
    func goNext() {
        withAnimation {
            switch viewState {
            case .accidentList:
                selectedTab = .location
                viewState = .start
                draft.reset()
            case .start:
                switch selectedTab {
                case .location:       selectedTab = .driver1
                case .driver1:        selectedTab = .driver2
                case .driver2:        selectedTab = .description
                case .description:    selectedTab = .pointOfImpact1
                case .pointOfImpact1: selectedTab = .pointOfImpact2
                case .pointOfImpact2: selectedTab = .mapView
                case .mapView:        selectedTab = .location
                }
            }
        }
    }
    
    func goBack() {
        withAnimation {
            switch viewState {
            case .accidentList:
                selectedTab = .location
                viewState = .start
            case .start:
                switch selectedTab {
                case .location:       selectedTab = .mapView
                case .driver1:        selectedTab = .location
                case .driver2:        selectedTab = .driver1
                case .description:    selectedTab = .driver2
                case .pointOfImpact1: selectedTab = .description
                case .pointOfImpact2: selectedTab = .pointOfImpact1
                case .mapView:        selectedTab = .pointOfImpact2
                }
            }
        }
    }
    
    func exitAndSaveReport() {
        createReportAndSave()
    }
    
    func exitWithoutSaving() {
        withAnimation {
            viewState = .accidentList
        }
    }
    
    func createReportAndSave() {
        let report = draft.createOrUpdateReport()
        
        Task {
            do {
                if draft.originalReport != nil {
                    // Update
                    try await repository.updateReport(report)
                } else {
                    // Save (Insert)
                    try await repository.saveReport(report)
                }
                await fetchAccidents()
                errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
            }
        }
        viewState = .accidentList
    }
    
    func removeReport(_ report: AccidentReport) {
        Task {
            do {
                try await repository.removeReport(report)
                accidentReports.removeAll { $0.id == report.id }
                errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func editReport(_ report: AccidentReport) {
        draft.load(from: report)
        withAnimation {
            selectedTab = .location
            viewState = .start
        }
    }
    
    func exportPDF(for report: AccidentReport) {
        guard let url = PDFManager.shared.renderPDF(with: report, templateImageName: "form") else {
            return
        }
        PDFManager.shared.sharePDF(url)
    }
    
    func showReportPreview(for report: AccidentReport) {
        reportToPreview = report
    }
    
    func closeReportPreview() {
        reportToPreview = nil
    }
}
