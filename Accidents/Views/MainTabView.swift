//
//  ContentView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: Router
    @StateObject var accidentListViewModel = AccidentListViewModel()
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            TabView {
                AccidentsView(viewModel: accidentListViewModel)
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
            .navigationDestination(for: Router.Destination.self) { destination in
                router.getViewForDestination(destination)
            }
        }
    }
}

#Preview {
    MainTabView()
}
