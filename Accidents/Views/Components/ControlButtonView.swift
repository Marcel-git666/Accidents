//
//  ControlButtonView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.04.2024.
//

import SwiftUI

struct ControlButtonView: View {
    @Binding var roadShape: RoadShapeSelector
    let vehicleManager: VehicleManager
    @Binding var selectedVehicle: Vehicle?
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                roadShape = .crossroad
            } label: {
                Image(systemName: "cross")
                    .foregroundColor(.black)
            }
            Button {
                roadShape = .normalRoad
            } label: {
                Image(systemName: "car.rear.road.lane")
                    .foregroundColor(.black)
            }
            Button {
                roadShape = .roundabout
            } label: {
                Image(systemName: "circle.circle")
                    .foregroundColor(.black)
            }
            HStack {
                Button {
                    vehicleManager.vehicles.removeAll()
                } label: {
                    Image(systemName: "clear")
                        .foregroundColor(.black)
                }
                Button {
                    if let selectedVehicle = selectedVehicle {
                        vehicleManager.removeVehicle(withId: selectedVehicle.id)
                        self.selectedVehicle = nil
                    }
                } label: {
                    Image(systemName: "selection.pin.in.out")
                        .foregroundColor(.black)
                }
            }
        }
    }
}


struct ControlButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let vehicleManager = VehicleManager()
        let roadShape = Binding.constant(RoadShapeSelector.crossroad)
        let selectedVehicle = Binding<Vehicle?>(get: { return Vehicle(id: "1", location: .zero, imageName: "car", rotationAngle: .zero, scale: 1.0) }, set: { _ in })
        
        return ControlButtonView(roadShape: roadShape, vehicleManager: vehicleManager, selectedVehicle: selectedVehicle)
    }
}
