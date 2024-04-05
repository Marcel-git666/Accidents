//
//  AccidentsView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentsNavigationView: View {
    @ObservedObject var presenter: AccidentsPresenter
    
    var body: some View {
        NavigationStack {
            VStack {
                switch presenter.viewState {
                case .start:
                        UpperTabBarView(presenter: presenter)
                            .transition(.slide)
                default:
                    AccidentsListView(presenter: presenter)
                        .transition(.slide)
                }
            }
            Spacer()
            VStack {
                if let errorMessage = presenter.errorMessage { ARErrorBlock(errorMessage: errorMessage)
                }
            }
            .navigationTitle(presenter.viewState != .start ? "Reports" : "")
        }
    }
}

#Preview {
    AccidentsNavigationView(presenter: MockPresenter(repository: MockDataRepository()))
}
