//
//  ContentView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var coordinator: AccidentsCoordinator?
    
    var body: some View {
            Group {
                if let coordinator {
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
                } else {
                    ProgressView()
                }
            }
            .onAppear {
                if coordinator == nil {
                    coordinator = AccidentsCoordinator(repository: SwiftDataRepository(context: modelContext))
                }
            }
        }
}

#Preview {
    MainTabView()
}
