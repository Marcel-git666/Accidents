//
//  MapView.swift
//  Accidents
//
//  Created by Marcel Mravec on 06.04.2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var vehicleManager: VehicleManager
    @State private var roadShapeSelector: RoadShapeSelector = .normalRoad
    
    var body: some View {
        ZStack {
            VStack {
                switch roadShapeSelector {
                case .crossroad:
                    Crossroad()
                        .stroke(Color.pink, style: StrokeStyle(lineWidth: 8))
                case .normalRoad:
                    NormalRoad()
                        .stroke(Color.pink, style: StrokeStyle(lineWidth: 8))
                case .roundabout:
                    NormalRoad()
                        .stroke(Color.pink, style: StrokeStyle(lineWidth: 8))
                }
            }
            .padding(.vertical, 50)
            
            VStack {
                HStack {
                    Button {
                        roadShapeSelector = .crossroad
                    } label: {
                        Text("Crossroad")
                    }
                    Button {
                        roadShapeSelector = .normalRoad
                    } label: {
                        Text("Normal road")
                    }
                    Button {
                        vehicleManager.addVehicle(location: CGPoint(x: 100, y: 100), imageName: "car") // Add car at origin (adjust location)
                    } label: {
                        Text("Car")
                    }
                    Button {
                        vehicleManager.addVehicle(location: CGPoint(x: 100, y: 100), imageName: "van")
                    } label: {
                        Text("Van")
                    }
                }
                Spacer()
                ForEach(vehicleManager.vehicles) { vehicle in
                    // Customize the view for each vehicle as needed
                    HStack {
                        DraggableView(vehicle: vehicle)
                            
                        
                    }
                }
                
                HStack {
                    Button("Clear All") {
                        vehicleManager.vehicles.removeAll()
                    }
                    Button("Remove Last") {
                        if !vehicleManager.vehicles.isEmpty {
                            vehicleManager.vehicles.removeLast()
                        }
                    }
                }
            }
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = VehicleManager() // Create a VehicleManager instance
        
        // Wrap MapView with environmentObject
        MapView()
            .environmentObject(manager)
            .previewLayout(.sizeThatFits) // Ensure preview fits content
    }
}
