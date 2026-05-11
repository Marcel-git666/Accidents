//
//  AccidentsListView.swift
//  Accidents
//
//  Created by Marcel Mravec on 20.03.2024.
//

import SwiftUI

struct AccidentsListView<C: AccidentsCoordinating>: View {
    let coordinator: C

    var body: some View {
        ZStack {
            List {
                ForEach(coordinator.accidentReports) { accident in
                    HStack {
                        Text("Accident in \(accident.accidentLocation.city)")
                            .font(.headline)
                            .onTapGesture {
                                coordinator.editReport(accident)
                            }

                        Spacer()

                        Button(action: {
                            coordinator.showReportPreview(for: accident)
                        }) {
                            Image(systemName: "doc.text.magnifyingglass")
                                .foregroundColor(.blue)
                        }

                        Button(action: {
                            coordinator.exportPDF(for: accident)
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.green)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            coordinator.removeReport(accident)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.listBackground)
            .refreshable {
                await coordinator.fetchAccidents()
            }
            .navigationBarItems(trailing: Button(action: {
                coordinator.goNext()
            }, label: {
                Label("New Accident", systemImage: "plus")
            }))

            if let reportToPreview = coordinator.reportToPreview {
                ReportPreviewWrapper(
                    report: reportToPreview,
                    templateImageName: "form"
                )
                .transition(.opacity)
                .zIndex(100)
                .onTapGesture {
                    coordinator.closeReportPreview()
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        AccidentsListView(coordinator: MockCoordinator())
    }
}
