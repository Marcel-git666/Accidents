//
//  AccidentsView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentsView: View {
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
            .alert(isPresented: $presenter.isErrorPresented) {
                Alert(title: Text("Error"), message: Text(presenter.errorMessage ?? "An unknown error occurred."), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                    presenter.fetchAccidents()
            }
            .navigationTitle("\(presenter.viewState.rawValue)")
        }
    }
}

#Preview {
    AccidentsView(presenter: MockPresenter(repository: MockDataRepository()))
}
