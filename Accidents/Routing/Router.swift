//
//  Router.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case location
    }
    
    @Published var navPath = NavigationPath()
    
    public func getViewForDestination(_ destination: Destination) -> AnyView {
        switch destination {
        case .location:
            return AnyView(AccidentLocationView())
        }
    }
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
