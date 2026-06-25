//
//  UpperTabBarView.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.03.2024.
//

import SwiftUI

struct UpperTabBarView<C: AccidentsCoordinating>: View {
    @Bindable var coordinator: C

    let swipeAnimation: Animation = .easeOut(duration: 0.3)
    let tapAnimation: Animation = .easeInOut(duration: 0.2)

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(AccidentReportFillingState.allCases) { tab in
                        UpperTabBarButton(
                            color: coordinator.selectedTab == tab ? Color.accentColor : Color.secondary,
                            systemImage: tab.systemImageName,
                            text: tab.rawValue,
                            isActive: coordinator.selectedTab == tab)
                        .onTapGesture {
                            withAnimation(tapAnimation) {
                                coordinator.handleSelectedTab(tab)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer()

            switch coordinator.selectedTab {
            case .location:
                AccidentLocationView(model: coordinator.draft.location)
            case .driver1:
                DriverView(model: coordinator.draft.driverA)
            case .driver2:
                DriverView(model: coordinator.draft.driverB)
            case .description:
                DescriptionView(model: coordinator.draft.description)
            case .pointOfImpact1:
                AccidentCrashPointView(model: coordinator.draft.impactA, isVehicleA: true)
            case .pointOfImpact2:
                AccidentCrashPointView(model: coordinator.draft.impactB, isVehicleA: false)
            case .mapView:
                AccidentSituationView(model: coordinator.draft.situation)
            }
        }
        .gesture(DragGesture(minimumDistance: 10)
            .onEnded { value in
                let translation = value.translation.width
                if translation > 0 {
                    coordinator.goBack()
                } else if translation < 0 {
                    coordinator.goNext()
                }
            })
    }
}

#Preview {
    UpperTabBarView(coordinator: MockCoordinator())
}
