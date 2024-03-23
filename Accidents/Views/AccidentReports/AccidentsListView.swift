//
//  AccidentsListView.swift
//  Accidents
//
//  Created by Marcel Mravec on 20.03.2024.
//

import SwiftUI

struct AccidentsListView: View {
    @ObservedObject var presenter: AccidentsPresenter
    
    var body: some View {
        ZStack {
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
                await presenter.fetchAccidents()
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                presenter.goNext()
            }) {
                Label("New Accident", systemImage: "plus")
            }
        )
            EmptyListView().opacity(presenter.accidentReports.isEmpty ? 1 : 0)
        }
    }
}

#Preview {
    NavigationView {
        AccidentsListView(presenter: AccidentsPresenter(repository: MockDataRepository()))
    }
}
