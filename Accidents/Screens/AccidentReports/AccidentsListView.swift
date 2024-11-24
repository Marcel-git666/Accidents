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
                    HStack {
                        // Accident text or primary content
                        AccidentListItemView(report: Binding(get: { accident }, set: { _ in }))
                        
                        Spacer() // Pushes the button to the trailing edge
                        
                        // PDF button
                        Button(action: {
                            presenter.generatePDF(for: accident)
                        }) {
                            Image(systemName: "doc.richtext")
                                .foregroundColor(.blue)
                                .padding(.trailing, 8) // Adds spacing to the button
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .contentShape(Rectangle()) // Makes the entire row tappable for editing
                    .onTapGesture {
                        presenter.editReport(accident)
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            presenter.removeReport(accident)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.listBackground)
            .refreshable {
                await presenter.fetchAccidents()
            }
            .navigationBarItems(trailing: Button(action: {
                presenter.goNext()
            }, label: {
                Label("New Accident", systemImage: "plus")
            }))
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
