//
//  AccidentsView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentsView: View {
    @ObservedObject var presenter: AccidentsPresenter
    
    var body: some View {
        NavigationStack {
            VStack {
                switch presenter.viewState {
                case .location:
                    accidentLocationView
                case .driver1:
                    DriverView(presenter: presenter, driverType: .driver1)
                case .driver2:
                    DriverView(presenter: presenter, driverType: .driver2)
                default:
                    accidentsView
                }
            }
            .alert(isPresented: $presenter.isErrorPresented) {
                Alert(title: Text("Error"), message: Text(presenter.errorMessage ?? "An unknown error occurred."), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                    presenter.fetchAccidents()
            }
            .navigationTitle("\(presenter.viewState.rawValue)")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

extension AccidentsView {
    @ViewBuilder
    var accidentsView: some View {
        
            List {
                ForEach(presenter.accidentReports) { accident in
                    AccidentListItemView(accident: accident)
                        .swipeActions(allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                presenter.removeReport(accident)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                }
            }
            
            .refreshable {
                presenter.fetchAccidents()
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                presenter.viewState = .location
            }) {
                Label("New Accident", systemImage: "plus")
            }
            )
        }
}

#Preview {
    AccidentsView(presenter: MockPresenter(repository: MockDataRepository()))
}

class MockPresenter: AccidentsPresenter {
    init(repository: MockDataRepository) {
        super.init(repository: repository)
        self.accidentReports = [AccidentReport.sampleData]
    }
}

struct MockDataRepository: AccidentReportRepository {
    func removeReport(_ report: AccidentReport, completion: @escaping (Result<Void, any Error>) -> Void) {
        // test
    }
    
  func fetchAll(completion: @escaping ([AccidentReport], (any Error)?) -> Void) {
    completion(([AccidentReport.sampleData]), (any Error)?.self as? Error)
  }
   
  func save(_ report: AccidentReport, completion: @escaping (Error?) -> Void) {
    // No-op for preview context
    completion(nil)
  }
}
