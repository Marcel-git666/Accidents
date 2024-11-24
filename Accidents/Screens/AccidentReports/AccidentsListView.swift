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
                    
                    NavigationLink(
                        destination: ReportPreviewView(
                            report: accident,
                            templateImageName: "form" // The name of the PNG file in your bundle
                        )
                    ) {
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
    }
    
}

#Preview {
    NavigationView {
        AccidentsListView(presenter: MockPresenter(repository: MockDataRepository()))
    }
}
