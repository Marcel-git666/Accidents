//
//  AccidentsView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentsView: View {
    @ObservedObject var presenter: AccidentsPresenter
    
    init() {
        presenter = AccidentsPresenter()
    }
    
    var body: some View {
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
        .navigationTitle("\(presenter.viewState.rawValue)")
    }
}

extension AccidentsView {
    @ViewBuilder
    var accidentsView: some View {
        NavigationView {
            List {
                ForEach(presenter.accidentReports) { accident in
                    AccidentListItemView(accident: accident)
                }
            }
            .navigationTitle("Accidents")
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
}

#Preview {
    AccidentsView()
}
