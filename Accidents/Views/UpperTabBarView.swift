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
            HStack(spacing: 16) {
                UpperTabBarButton(color: presenter.selectedTab == .location ? Color.accentColor : Color.secondary, systemImage: "map", text: "\(AccidentReportFillingState.location.rawValue)", isActive: presenter.selectedTab == .location)
                    .onTapGesture {
                        presenter.selectedTab = .location
                    }
                UpperTabBarButton(color: presenter.selectedTab == .driver1 ? Color.accentColor : Color.secondary, systemImage: "person.fill", text: "\(AccidentReportFillingState.driver1.rawValue)", isActive: presenter.selectedTab == .driver1)
                    .onTapGesture {
                        presenter.selectedTab = .driver1
                    }
                UpperTabBarButton(color: presenter.selectedTab == .driver2 ? Color.accentColor : Color.secondary, systemImage: "person.fill", text: "\(AccidentReportFillingState.driver2.rawValue)", isActive: presenter.selectedTab == .driver2)
                    .onTapGesture {
                        presenter.selectedTab = .driver2
                    }
                UpperTabBarButton(color: presenter.selectedTab == .description ? Color.accentColor : Color.secondary, systemImage: "pencil.and.ruler.fill", text: "\(AccidentReportFillingState.description.rawValue)", isActive: presenter.selectedTab == .description)
                    .onTapGesture {
                        presenter.selectedTab = .description
                    }
            }
            
            //            .background(LinearGradient(colors: [.orange, Color(UIColor.systemGray)], startPoint: .topLeading, endPoint: .top).edgesIgnoringSafeArea(.all))
            
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
