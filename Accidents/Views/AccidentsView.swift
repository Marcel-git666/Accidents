//
//  AccidentsView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentsView: View {
  @ObservedObject var accidentsViewModel: AccidentsViewModel

  var body: some View {
    NavigationView {
      List {
        ForEach(accidentsViewModel.accidentReports) { accident in
          AccidentListItemView(accident: accident)
        }
      }
      .navigationTitle("Accidents")
      .refreshable {
        accidentsViewModel.fetchAccidents()
      }
      .navigationBarItems(trailing:
        Button(action: {
          accidentsViewModel.startAccidentReporting()
        }) {
          Label("New Accident", systemImage: "plus")
        }
      )
    }
  }
}

//#Preview {
//    let coordinator: AccidentReportCoordinator
//    var sampleViewModel = AccidentsViewModel(coordinator: coordinator)
//    sampleViewModel.accidentReports = [AccidentReport.sampleData]
//    return AccidentsView(accidentsViewModel: sampleViewModel)
//}
