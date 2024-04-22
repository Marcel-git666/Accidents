//
//  VehicleButtonView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.04.2024.
//

import SwiftUI

struct VehicleButtonView: View {
    let presenter: AccidentsPresenter
    let vehicleManager: VehicleManager
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                vehicleManager.addOtherVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.motorcycle, rotationAngle: .zero, scale: 0.8)
            } label: {
                Image(systemName: "bicycle")
                    .foregroundColor(.black)
            }
            Button {
                vehicleManager.addOtherVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.car, rotationAngle: .zero, scale: 1.0)
                presenter.accidentSituation.otherVehicles.append(vehicleManager.vehicles.last!)
            } label: {
                Image(systemName: "car")
                    .foregroundColor(.black)
            }
            Button {
                vehicleManager.addOtherVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.van, rotationAngle: .zero, scale: 1.0)
            } label: {
                Image(systemName: "truck.box")
                    .foregroundColor(.black)
            }
            Button {
                vehicleManager.addYellowVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.yellowMotorcycle, rotationAngle: .zero, scale: 0.8)
            } label: {
                Image(systemName: "bicycle")
                    .foregroundColor(.yellow)
            }
            Button {
                vehicleManager.addBlueVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.blueMotorcycle, rotationAngle: .zero, scale: 0.8)
            } label: {
                Image(systemName: "bicycle")
                    .foregroundColor(.blue)
            }
            Button {
                vehicleManager.addYellowVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.yellowCar, rotationAngle: .zero, scale: 1)
            } label: {
                Image(systemName: "car")
                    .foregroundColor(.yellow)
            }
            Button {
                vehicleManager.addBlueVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.blueCar, rotationAngle: .zero, scale: 1)
            } label: {
                Image(systemName: "car")
                    .foregroundColor(.blue)
            }
            Button {
                vehicleManager.addYellowVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.yellowVan, rotationAngle: .zero, scale: 1)
            } label: {
                Image(systemName: "truck.box")
                    .foregroundColor(.yellow)
            }
            Button {
                vehicleManager.addBlueVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.blueVan, rotationAngle: .zero, scale: 1)
            } label: {
                Image(systemName: "truck.box")
                    .foregroundColor(.blue)
            }
        }
    }
}


#Preview {
    VehicleButtonView(presenter: MockPresenter(repository: MockDataRepository()), vehicleManager: VehicleManager())
}
