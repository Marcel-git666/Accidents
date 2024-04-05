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
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(AccidentReportFillingState.allCases) { tab in
                        UpperTabBarButton(color: presenter.selectedTab == tab ? Color.accentColor : Color.secondary,
                                          systemImage: tab.systemImageName,
                                          text: tab.rawValue,
                                          isActive: presenter.selectedTab == tab)
                        .onTapGesture {
                            presenter.handleSelectedTab(tab)
                        }
                    }
                    
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            switch presenter.selectedTab {
            case .location:
                AccidentLocationView(presenter: presenter)
                    .transition(.scale)
            case .driver1:
                DriverView(presenter: presenter, driver: $presenter.accidentDriver1)
                    .transition(.scale)
                
            case .driver2:
                DriverView(presenter: presenter, driver: $presenter.accidentDriver2)
                    .transition(.scale)
                
            case .description:
                DescriptionView(presenter: presenter)
                    .transition(.scale)
                
            case .pointOfImpact1:
                AccidentCrashPointView(presenter: presenter, pointOfImpact: $presenter.pointOfImpact1)
                    .transition(.scale)
            case .pointOfImpact2:
                AccidentCrashPointView(presenter: presenter, pointOfImpact: $presenter.pointOfImpact2)
                    .transition(.scale)
            }
        }
    }
}

#Preview {
    UpperTabBarView(presenter: MockPresenter(repository: MockDataRepository()))
}
