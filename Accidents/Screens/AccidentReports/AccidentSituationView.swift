//
//  AccidentSituationView.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.03.2024.
//

import SwiftUI

struct AccidentSituationView: View {
    @ObservedObject var presenter: AccidentsPresenter
    @EnvironmentObject var vehicleManager: VehicleManager
    @Binding var accidentSituation: AccidentSituation
    @State private var selectedVehicle: Vehicle?
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.4)
                .ignoresSafeArea()
            RoadShapeView(roadShape: accidentSituation.roadShape)
                .padding(.vertical, 50)
            
            VStack {
                VehicleButtonView(presenter: presenter, vehicleManager: vehicleManager)
                HStack {
                    ControlButtonView(
                        roadShape: $accidentSituation.roadShape,
                        vehicleManager: vehicleManager,
                        selectedVehicle: $selectedVehicle)
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.top)
            // Vehicles
            ForEach($vehicleManager.vehicles) { $vehicle in
                DraggableView(vehicle: $vehicle)
                    .onTapGesture {
                        selectedVehicle = vehicle
                    }
            }
            
            RotationButtoView(vehicleManager: vehicleManager, selectedVehicle: $selectedVehicle)
            ScaleButtonView(vehicleManager: vehicleManager, selectedVehicle: $selectedVehicle)
//            ActionButtonView(presenter: presenter, vehicleManager: vehicleManager)
        }
        .onAppear {
            presenter.syncVehiclesWithManager()
        }
    }
}

struct AccidentSituationView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock data for preview
        let manager = VehicleManager()
        let mockAccidentSituation = AccidentSituation(
            roadShape: .crossroad,
            blueVehicle: Vehicle(id: UUID().uuidString, location: CGPoint(x: 100, y: 100), imageName: "blueCar", rotationAngle: Angle(degrees: 30), scale: 1),
            yellowVehicle: Vehicle(id: UUID().uuidString, location: CGPoint(x: 200, y: 200), imageName: "yellowCar", rotationAngle: Angle(degrees: -45), scale: 1),
            otherVehicles: [
                Vehicle(id: UUID().uuidString, location: CGPoint(x: 150, y: 150), imageName: "bike", rotationAngle: Angle(degrees: 90), scale: 1)
            ]
        )
        
        @State var accidentSituation = mockAccidentSituation
        
        return VStack {
            HStack(spacing: 20) {
                Spacer()
                UpperTabBarButton(color: .accent, systemImage: "book", text: "something", isActive: true)
                Spacer()
            }
            .background(Color.gray.opacity(0.4))
            .padding()
            
            TabView {
                AccidentSituationView(
                    presenter: AccidentsPresenter(repository: MockDataRepository()),
                    accidentSituation: $accidentSituation
                )
                .environmentObject(manager)
                .tabItem {
                    Label("Road Shape", systemImage: "cross")
                }
            }
        }
    }
}

