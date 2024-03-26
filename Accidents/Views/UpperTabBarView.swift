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
                        .foregroundColor(presenter.selectedTab == .location ? Color.white : Color.secondary)
                    Text("\(AccidentReportFillingState.location.rawValue)")
                }
                .onTapGesture {
                    presenter.selectedTab = .location
                }
                Spacer()
                VStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(presenter.selectedTab == .driver1 ? Color.white : Color.secondary)
                    Text("\(AccidentReportFillingState.driver1.rawValue)")
                }
                .onTapGesture {
                    presenter.selectedTab = .driver1
                }
                Spacer()
                VStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(presenter.selectedTab == .driver2 ? Color.white : Color.secondary)
                    Text("\(AccidentReportFillingState.driver2.rawValue)")
                }
                .onTapGesture {
                    presenter.selectedTab = .driver2
                }
                Spacer()
                VStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(presenter.selectedTab == .description ? Color.white : Color.secondary)
                    Text("\(AccidentReportFillingState.description.rawValue)")
                }
                .onTapGesture {
                    presenter.selectedTab = .description
                }
            }
            .padding(.bottom)
            .background(LinearGradient(colors: [.orange, .accentColor], startPoint: .topLeading, endPoint: .top).edgesIgnoringSafeArea(.all))
            
            Spacer()
            switch presenter.selectedTab {
            
            case .location:
                    AccidentLocationView(presenter: presenter)
                        .transition(.scale)
            case .driver1:
                    DriverView(presenter: presenter, driverType: .driver1)
                        .transition(.scale)
                
            case .driver2:
                    DriverView(presenter: presenter, driverType: .driver2)
                        .transition(.scale)
                
            case .description:
                    DescriptionView(presenter: presenter)
                        .transition(.scale)
                
            }
        }
    }
}

#Preview {
    UpperTabBarView(presenter: MockPresenter(repository: MockDataRepository()))
}
