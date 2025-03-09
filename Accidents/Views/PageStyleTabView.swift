//
//  PageStyleTabView.swift
//  Accidents
//
//  Created by Marcel Mravec on 09.03.2025.
//

import SwiftUI

struct PageStyleTabView: View {
    @ObservedObject var presenter: AccidentsPresenter
    @State private var selectedTabIndex = 0
    
    private var tabStates: [AccidentReportFillingState] {
        return AccidentReportFillingState.allCases
    }
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            AccidentLocationView(presenter: presenter)
                .tag(0)
            DriverView(presenter: presenter, driver: $presenter.accidentDriver1)
                .tag(1)
            DriverView(presenter: presenter, driver: $presenter.accidentDriver2)
                .tag(2)
            DescriptionView(presenter: presenter)
                .tag(3)
            AccidentCrashPointView(presenter: presenter, pointOfImpact: $presenter.pointOfImpact1)
                .tag(4)
            AccidentCrashPointView(presenter: presenter, pointOfImpact: $presenter.pointOfImpact2)
                .tag(5)
            AccidentSituationView(presenter: presenter, accidentSituation: $presenter.accidentSituation)
                .environmentObject(presenter.vehicleManager)
                .tag(6)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .onChange(of: selectedTabIndex) { oldValue, newValue in
            // Save current state whenever the tab changes
            presenter.saveCurrentState()
            
            switch newValue {
            case 0: presenter.selectedTab = .location
            case 1: presenter.selectedTab = .driver1
            case 2: presenter.selectedTab = .driver2
            case 3: presenter.selectedTab = .description
            case 4: presenter.selectedTab = .pointOfImpact1
            case 5: presenter.selectedTab = .pointOfImpact2
            case 6: presenter.selectedTab = .mapView
            default: break
            }
        }
        .safeAreaInset(edge: .top) {
            // Top title bar showing current page
            HStack {
                Text(tabStates[selectedTabIndex].rawValue)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                // Optional: Progress indicator
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
            ACButton(label: "Exit", systemImage: "arrow.left.circle") {
                presenter.exitAndSaveReport()
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 8)
        }
        .onAppear {
            switch presenter.selectedTab {
            case .location: selectedTabIndex = 0
            case .driver1: selectedTabIndex = 1
            case .driver2: selectedTabIndex = 2
            case .description: selectedTabIndex = 3
            case .pointOfImpact1: selectedTabIndex = 4
            case .pointOfImpact2: selectedTabIndex = 5
            case .mapView: selectedTabIndex = 6
            }
        }
    }
}

#Preview {
    PageStyleTabView(presenter: MockPresenter(repository: MockDataRepository()))
}
