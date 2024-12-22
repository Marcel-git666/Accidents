//
//  UpperTabBarView.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.03.2024.
//

import SwiftUI

struct UpperTabBarView: View {
    @ObservedObject var presenter: AccidentsPresenter
    
    let swipeAnimation: Animation = .easeOut(duration: 0.3)
    let tapAnimation: Animation = .easeInOut(duration: 0.2)
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
                            withAnimation(tapAnimation) {
                                presenter.transitionEffect = .scale
                                presenter.handleSelectedTab(tab)
                            }
                            
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            switch presenter.selectedTab {
            case .location:
                AccidentLocationView(presenter: presenter)
                    .transition(presenter.transitionEffect)
            case .driver1:
                DriverView(presenter: presenter, driver: $presenter.accidentDriver1)
                    .transition(presenter.transitionEffect)
                
            case .driver2:
                DriverView(presenter: presenter, driver: $presenter.accidentDriver2)
                    .transition(presenter.transitionEffect)
                
            case .description:
                DescriptionView(presenter: presenter)
                    .transition(presenter.transitionEffect)
                
            case .pointOfImpact1:
                AccidentCrashPointView(presenter: presenter, pointOfImpact: $presenter.pointOfImpact1)
                    .transition(presenter.transitionEffect)
            case .pointOfImpact2:
                AccidentCrashPointView(presenter: presenter, pointOfImpact: $presenter.pointOfImpact2)
                    .transition(presenter.transitionEffect)
            case .mapView:
                AccidentSituationView(presenter: presenter, accidentSituation: $presenter.accidentSituation)
                    .environmentObject(presenter.vehicleManager)
                    .transition(presenter.transitionEffect)
            }
        }
        .gesture(DragGesture(minimumDistance: 10) // Adjust as needed
            .onEnded { value in
                let translation = value.translation.width
                if translation > 0 { // Swipe right
                    presenter.transitionEffect = .slideFromLeft
                    presenter.goBack()
                } else if translation < 0 { // Swipe left
                    presenter.transitionEffect = .slideFromRight
                    presenter.goNext()
                }
            })
        
    }
}

#Preview {
    UpperTabBarView(presenter: MockPresenter(repository: MockDataRepository()))
}
