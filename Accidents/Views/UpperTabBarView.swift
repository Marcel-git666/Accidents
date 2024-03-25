//
//  UpperTabBarView.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.03.2024.
//

import SwiftUI

struct UpperTabBarView: View {
    @ObservedObject var presenter: AccidentsPresenter
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "airplane")
                        .foregroundColor(presenter.selectedTab == .location ? Color.accentColor : Color.secondary)
                    Text("\(AccidentReportFillingState.location.rawValue)")
                }
                .onTapGesture {
                    presenter.selectedTab = .location
                }
                Spacer()
                VStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(presenter.selectedTab == .driver1 ? Color.accentColor : Color.secondary)
                    Text("\(AccidentReportFillingState.driver1.rawValue)")
                }
                .onTapGesture {
                    presenter.selectedTab = .driver1
                }
                Spacer()
                VStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(presenter.selectedTab == .driver2 ? Color.accentColor : Color.secondary)
                    Text("\(AccidentReportFillingState.driver2.rawValue)")
                }
                .onTapGesture {
                    presenter.selectedTab = .driver2
                }
                Spacer()
            }
            .padding(.bottom)
            .background(Color.teal.edgesIgnoringSafeArea(.all))
            
            Spacer()
            switch presenter.selectedTab {
            
            case .location:
                AccidentLocationView(presenter: presenter)
            case .driver1:
                DriverView(presenter: presenter, driverType: .driver1)
            case .driver2:
                DriverView(presenter: presenter, driverType: .driver2)
            case .description:
                EmptyListView()
            }
        }
    }
}

#Preview {
    UpperTabBarView(presenter: MockPresenter(repository: MockDataRepository()))
}
