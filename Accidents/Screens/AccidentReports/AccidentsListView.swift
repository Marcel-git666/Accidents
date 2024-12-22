//
//  AccidentsListView.swift
//  Accidents
//
//  Created by Marcel Mravec on 20.03.2024.
//

import SwiftUI

struct AccidentsListView: View {
    @ObservedObject var presenter: AccidentsPresenter
    @State private var selectedReport: AccidentReport?
    
    var body: some View {
        ZStack {
            List {
                ForEach(presenter.accidentReports) { accident in
                    HStack {
                        // Accident information
                        Text("Accident in \(accident.accidentLocation.city)")
                            .font(.headline)
                            .onTapGesture {
                                presenter.editReport(accident)
                            }
                        
                        Spacer()
                        
                        Button(action: {
                            presenter.showReportPreview(for: accident)
                        }) {
                            Image(systemName: "doc.text.magnifyingglass")
                                .foregroundColor(.blue)
                        }
                        
                        // Export Button
                        Button(action: {
                            presenter.exportPDF(for: accident)
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.green)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            presenter.removeReport(accident)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
            }
            if let reportToPreview = presenter.reportToPreview {
                ReportPreviewWrapper(
                    report: reportToPreview,
                    templateImageName: "form"
                )
                .transition(.move(edge: .bottom)) // Optional animation
                .onTapGesture {
                    // Close the preview on tap (or add a close button inside the preview)
                    presenter.closeReportPreview()
                }
            }
        }
    }
    
}

#Preview {
    NavigationView {
        AccidentsListView(presenter: MockPresenter(repository: MockDataRepository()))
    }
}
