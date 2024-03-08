//
//  ContentView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var coordinator = AccidentReportCoordinator(
        accidentReportService: AccidentReportService(),
        locationService: LocationService(),
        driver1DataService: DriverDataService(),
        driver2DataService: DriverDataService()
    )
    
    private var accidentsViewModel: AccidentsViewModel {
        AccidentsViewModel(coordinator: coordinator)
    }

    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            TabView {
                AccidentsView(accidentsViewModel: accidentsViewModel)
                    .tabItem {
                        Label("Accidents", systemImage: "car.2.fill")
                    }
                PreloadDataView()
                    .tabItem {
                        Label("Data", systemImage: "filemenu.and.cursorarrow")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .navigationDestination(for: AccidentReportFillingState.self) { state in
                coordinator.getViewForState(state)
            }
        }
    }
}


#Preview {
    MainTabView()
}
