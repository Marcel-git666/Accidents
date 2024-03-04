//
//  AccidentsApp.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

@main
struct AccidentsApp: App {
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .environmentObject(router)
    }
}
