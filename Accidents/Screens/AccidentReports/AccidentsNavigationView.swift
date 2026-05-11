//
//  AccidentsView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentsNavigationView<C: AccidentsCoordinating>: View {
    let coordinator: C

    var body: some View {
        NavigationStack {
            VStack {
                switch coordinator.viewState {
                case .start:
                    PageStyleTabView(coordinator: coordinator)
                        .transition(.scale(0.5))
                default:
                    AccidentsListView(coordinator: coordinator)
                        .transition(.slide)
                }
            }
            Spacer()
            VStack {
                if let errorMessage = coordinator.errorMessage {
                    ARErrorBlock(errorMessage: errorMessage)
                }
            }
            .navigationTitle(coordinator.viewState != .start ? "Reports" : "")
        }
    }
}

#Preview {
    AccidentsNavigationView(coordinator: MockCoordinator())
}
