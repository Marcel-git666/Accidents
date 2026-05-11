//
//  ContentView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct MainTabView: View {
    @State private var coordinator = AccidentsCoordinator(repository: CoreDataRepository())

    var body: some View {
        TabView {
            AccidentsNavigationView(coordinator: coordinator)
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
    }
}

#Preview {
    MainTabView()
}
