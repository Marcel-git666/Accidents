//
//  AccidentsView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentsView: View {
    @ObservedObject var viewModel: AccidentListViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.accidentReports) { accident in
                    AccidentListItemView(accident: accident) // Display each accident
                }
            }
            .navigationTitle("Accidents")
            .refreshable { // Allow refreshing to potentially fetch new data
                viewModel.fetchAccidents() // Call the view model's fetch method
            }
            .navigationBarItems(trailing:
                Button(action: {
                    router.navigate(to: .location) // Delegate navigation to view model
                }) {
                    Label("New Accident", systemImage: "plus") // Label and icon
                }
            )
        }
    }
}

#Preview {
    var sampleViewModel = AccidentListViewModel()
    sampleViewModel.accidentReports = [AccidentReport.sampleData]
    return AccidentsView(viewModel: sampleViewModel)
}
