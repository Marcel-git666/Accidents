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
                case .location:
                    AccidentLocationView(presenter: presenter)
                case .driver1:
                    DriverView(presenter: presenter, driverType: .driver1)
                case .driver2:
                    DriverView(presenter: presenter, driverType: .driver2)
                default:
                    AccidentsListView(presenter: presenter)
                }
            }
            Spacer()
            VStack {
                if let errorMessage = presenter.errorMessage { ARErrorBlock(errorMessage: errorMessage)
                }
            }
            .navigationTitle("\(presenter.viewState.rawValue)")
        }
    }
}

#Preview {
    AccidentsNavigationView(presenter: MockPresenter(repository: MockDataRepository()))
}
