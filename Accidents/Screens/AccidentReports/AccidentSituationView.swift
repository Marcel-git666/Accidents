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
    @State private var selectedVehicle: Vehicle? = nil
    @State private var rotationAngle: Angle = .degrees(0)
    @State private var scaleValue: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.4)
                .ignoresSafeArea()
            RoadShapeView(roadShape: presenter.accidentSituation.roadShape)
                .padding(.vertical, 50)
            
            VStack {
                VehicleButtonView(presenter: presenter, vehicleManager: vehicleManager)
                HStack {
                    ControlButtonView(roadShape: $presenter.accidentSituation.roadShape, vehicleManager: vehicleManager, selectedVehicle: $selectedVehicle)
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
            ActionButtonView(presenter: presenter, vehicleManager: vehicleManager)
        }
        .onAppear {
            loadVehiclesToAccidentSituation()
            print(presenter.accidentSituation)
        }
    }
    
    func loadVehiclesToAccidentSituation() {
        // Clear existing vehicles
        vehicleManager.vehicles.removeAll()
        
        // Load other vehicles from presenter.accidentSituation
        presenter.accidentSituation.otherVehicles.forEach { vehicle in
            vehicleManager.addOtherVehicle(location: vehicle.location, imageName: vehicle.imageName, rotationAngle: rotationAngle, scale: scaleValue)
        }
        
        // Load blue vehicle, if available
        if let blueVehicle = presenter.accidentSituation.blueVehicle {
            vehicleManager.addBlueVehicle(location: blueVehicle.location, imageName: blueVehicle.imageName, rotationAngle: rotationAngle, scale: scaleValue)
        }
        
        // Load yellow vehicle, if available
        if let yellowVehicle = presenter.accidentSituation.yellowVehicle {
            vehicleManager.addYellowVehicle(location: yellowVehicle.location, imageName: yellowVehicle.imageName, rotationAngle: rotationAngle, scale: scaleValue)
        }
    }
}


struct AccidentSituationView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = VehicleManager()
        VStack {
            HStack(spacing: 20) {
                Spacer()
                UpperTabBarButton(color: .accent, systemImage: "book", text: "something", isActive: true)
                Spacer()
            }
            .background(Color.gray.opacity(0.4))
            .padding()
            
            TabView {
                AccidentSituationView(presenter: AccidentsPresenter(repository: MockDataRepository()))
                    .environmentObject(manager)
                    .tabItem {
                        Label("Road Shape", systemImage: "cross")
                    }
                
            }
        }
    }
}
