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
                    let accidentBinding = Binding(get: { accident }, set: { _ in })
                    AccidentListItemView(report: accidentBinding)
                        .swipeActions(allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                presenter.removeReport(accident)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                        .onTapGesture {
                            presenter.editReport(accident)
                        }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.listBackground)
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
//            if let errorMessage = presenter.errorMessage {
//                ARErrorBlock(errorMessage: errorMessage)
//            }
        }
    }
}

#Preview {
    NavigationView {
        AccidentsListView(presenter: MockPresenter(repository: MockDataRepository()))
    }
}
