//
//  AccidentsApp.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

@main
struct AccidentsApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext())
        }
    }
}
