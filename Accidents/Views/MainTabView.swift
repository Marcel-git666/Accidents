//
//  ContentView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var presenter = AccidentsPresenter(
        repository: CoreDataRepository())
    
    var body: some View {
        TabView {
            AccidentsView(presenter: presenter)
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
