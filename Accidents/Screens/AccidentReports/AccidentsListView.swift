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
                        // 1. Přidáme VStack pro Město a Datum pod sebou
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Accident in \(accident.accidentLocation.city)")
                                .font(.headline)
                            
                            Text(accident.accidentLocation.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Button(action: {
                            coordinator.showReportPreview(for: accident)
                        }) {
                            Image(systemName: "doc.text.magnifyingglass")
                                .foregroundColor(.blue)
                                .padding(.horizontal, 4)
                        }
                        .buttonStyle(BorderlessButtonStyle())

                        Button(action: {
                            coordinator.exportPDF(for: accident)
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.green)
                                .padding(.horizontal, 4)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    // 2. Kouzlo pro UX: Udělá celý obdélník řádku klikatelný, i když je tam prázdné místo
                    .contentShape(Rectangle())
                    // 3. Přesunuli jsme TapGesture z Textu na celý HStack
                    .onTapGesture {
                        coordinator.editReport(accident)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
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
