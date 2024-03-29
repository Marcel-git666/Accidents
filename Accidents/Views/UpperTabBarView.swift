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
                    UpperTabBarButton(color: presenter.selectedTab == .pointOfImpact1 ? Color.accentColor : Color.secondary, systemImage: "car.top.radiowaves.rear.left.fill", text: "\(AccidentReportFillingState.pointOfImpact1.rawValue)", isActive: presenter.selectedTab == .pointOfImpact1)
                        .onTapGesture {
                            presenter.selectedTab = .pointOfImpact1
                        }
                    UpperTabBarButton(color: presenter.selectedTab == .pointOfImpact2 ? Color.accentColor : Color.secondary, systemImage: "car.top.radiowaves.rear.left.fill", text: "\(AccidentReportFillingState.pointOfImpact2.rawValue)", isActive: presenter.selectedTab == .pointOfImpact2)
                        .onTapGesture {
                            presenter.selectedTab = .pointOfImpact2
                        }
                    
                }
            }
            
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
                
            case .pointOfImpact1:
                AccidentCrashPointView(presenter: presenter)
                    .transition(.scale)
            case .pointOfImpact2:
                AccidentCrashPointView(presenter: presenter)
                    .transition(.scale)
            }
        }
    }
    
    private func calculateScrollOffset(for tab: AccidentReportFillingState, totalWidth: CGFloat) -> CGFloat {
        let buttonIndex = AccidentReportFillingState.allCases.firstIndex(of: tab)!
        let buttonWidth = (totalWidth - CGFloat(AccidentReportFillingState.allCases.count - 1) * 20) / CGFloat(AccidentReportFillingState.allCases.count)
        let offset = CGFloat(buttonIndex) * (buttonWidth + 20) // Account for spacing
        return offset
    }
}

#Preview {
    UpperTabBarView(presenter: MockPresenter(repository: MockDataRepository()))
}
