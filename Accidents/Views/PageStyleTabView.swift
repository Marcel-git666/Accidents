//
//  PageStyleTabView.swift
//  Accidents
//
//  Created by Marcel Mravec on 09.03.2025.
//

import SwiftUI

struct PageStyleTabView<C: AccidentsCoordinating>: View {
    @Bindable var coordinator: C
    @State private var selectedTabIndex = 0

    private var tabStates: [AccidentReportFillingState] {
        AccidentReportFillingState.allCases
    }

    var body: some View {
        TabView(selection: $selectedTabIndex) {
            AccidentLocationView(model: coordinator.draft.location)
                .tag(0)
            DriverView(model: coordinator.draft.driverA)
                .tag(1)
            DriverView(model: coordinator.draft.driverB)
                .tag(2)
            DescriptionView(model: coordinator.draft.description)
                .tag(3)
            AccidentCrashPointView(model: coordinator.draft.impactA, isVehicleA: true)
                .tag(4)
            AccidentCrashPointView(model: coordinator.draft.impactB, isVehicleA: false)
                .tag(5)
            AccidentSituationView(model: coordinator.draft.situation)
                .tag(6)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .onChange(of: selectedTabIndex) { _, newValue in
            switch newValue {
            case 0: coordinator.selectedTab = .location
            case 1: coordinator.selectedTab = .driver1
            case 2: coordinator.selectedTab = .driver2
            case 3: coordinator.selectedTab = .description
            case 4: coordinator.selectedTab = .pointOfImpact1
            case 5: coordinator.selectedTab = .pointOfImpact2
            case 6: coordinator.selectedTab = .mapView
            default: break
            }
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Text(tabStates[selectedTabIndex].rawValue)
                    .font(.headline)
                    .foregroundColor(.primary)

                Spacer()

                Text("\(selectedTabIndex + 1)/\(tabStates.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(
                Rectangle()
                    .fill(Color(UIColor.systemBackground))
                    .shadow(radius: 2)
            )
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 16) {
                ACButton(label: "Cancel", systemImage: "xmark.circle") {
                    coordinator.exitWithoutSaving()
                }
                
                ACButton(label: "Save", systemImage: "checkmark.circle") {
                    coordinator.exitAndSaveReport()
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 8)
        }
        .onAppear {
            switch coordinator.selectedTab {
            case .location:       selectedTabIndex = 0
            case .driver1:        selectedTabIndex = 1
            case .driver2:        selectedTabIndex = 2
            case .description:    selectedTabIndex = 3
            case .pointOfImpact1: selectedTabIndex = 4
            case .pointOfImpact2: selectedTabIndex = 5
            case .mapView:        selectedTabIndex = 6
            }
        }
    }
}

#Preview {
    PageStyleTabView(coordinator: MockCoordinator())
}
