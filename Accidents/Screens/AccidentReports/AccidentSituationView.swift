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
            VStack {
                switch presenter.accidentSituation.roadShape {
                case .crossroad:
                    Crossroad()
                        .stroke(Color.pink, style: StrokeStyle(lineWidth: 8))
                case .normalRoad:
                    NormalRoad()
                        .stroke(Color.pink, style: StrokeStyle(lineWidth: 8))
                case .roundabout:
                    Roundabout()
                        .stroke(Color.pink, style: StrokeStyle(lineWidth: 8))
                }
            }
            .padding(.vertical, 50)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(spacing: 20) {
                        Button {
                            presenter.accidentSituation.roadShape = .crossroad
                        } label: {
                            Image(systemName: "cross")
                                .foregroundColor(.black)
                        }
                        Button {
                            presenter.accidentSituation.roadShape = .normalRoad
                        } label: {
                            Image(systemName: "car.rear.road.lane")
                                .foregroundColor(.black)
                        }
                        Button {
                            presenter.accidentSituation.roadShape = .roundabout
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
                    
                    Button {
                        vehicleManager.addOtherVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.motorcycle)
                    } label: {
                        Image(systemName: "bicycle")
                            .foregroundColor(.black)
                    }
                    Button {
                        vehicleManager.addOtherVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.car)
                        presenter.accidentSituation.otherVehicles.append(vehicleManager.vehicles.last!)
                    } label: {
                        Image(systemName: "car")
                            .foregroundColor(.black)
                    }
                    Button {
                        vehicleManager.addOtherVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.van)
                    } label: {
                        Image(systemName: "truck.box")
                            .foregroundColor(.black)
                    }
                    Button {
                        vehicleManager.addYellowVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.yellowMotorcycle)
                    } label: {
                        Image(systemName: "bicycle")
                            .foregroundColor(.yellow)
                    }
                    Button {
                        vehicleManager.addBlueVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.blueMotorcycle)
                    } label: {
                        Image(systemName: "bicycle")
                            .foregroundColor(.blue)
                    }
                    Button {
                        vehicleManager.addYellowVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.yellowCar)
                    } label: {
                        Image(systemName: "car")
                            .foregroundColor(.yellow)
                    }
                    Button {
                        vehicleManager.addBlueVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.blueCar)
                    } label: {
                        Image(systemName: "car")
                            .foregroundColor(.blue)
                    }
                    Button {
                        vehicleManager.addYellowVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.yellowVan)
                    } label: {
                        Image(systemName: "truck.box")
                            .foregroundColor(.yellow)
                    }
                    Button {
                        vehicleManager.addBlueVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.blueVan)
                    } label: {
                        Image(systemName: "truck.box")
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
                
                // Vehicles
                ForEach($vehicleManager.vehicles) { $vehicle in
                    DraggableView(vehicle: $vehicle)
                        .onTapGesture {
                            selectedVehicle = vehicle
                        }
                }
                
            }
            .padding(.top)
            VStack {
                Button(action: {
                    if let selectedVehicle = selectedVehicle {
                        rotateClockwise(vehicle: selectedVehicle)
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                        .padding()
                }
                .disabled(selectedVehicle == nil)
                
                Button(action: {
                    if let selectedVehicle = selectedVehicle {
                        rotateAntiClockwise(vehicle: selectedVehicle)
                    }
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .padding()
                }
                .disabled(selectedVehicle == nil)
            }
            .position(x: UIScreen.main.bounds.maxX - 50, y: UIScreen.main.bounds.midY - 50)
            VStack {
                Button(action: {
                    if let selectedVehicle = selectedVehicle {
                        scaleUp(vehicle: selectedVehicle)
                    }
                }) {
                    Image(systemName: "plus")
                        .padding()
                }
                .disabled(selectedVehicle == nil)
                
                Button(action: {
                    if let selectedVehicle = selectedVehicle {
                        scaleDown(vehicle: selectedVehicle)
                    }
                }) {
                    Image(systemName: "minus")
                        .padding()
                }
                .disabled(selectedVehicle == nil)
            }
            .position(x: 50, y: UIScreen.main.bounds.midY - 50)
        }
    }
    
    func rotateClockwise(vehicle: Vehicle) {
        guard let index = vehicleManager.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        vehicleManager.vehicles[index].rotationAngle += Angle.degrees(15)
    }
    
    func rotateAntiClockwise(vehicle: Vehicle) {
        guard let index = vehicleManager.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        vehicleManager.vehicles[index].rotationAngle -= Angle.degrees(15)
    }
    
    func scaleUp(vehicle: Vehicle) {
        guard let index = vehicleManager.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        vehicleManager.vehicles[index].scale *= 1.1
    }
    
    func scaleDown(vehicle: Vehicle) {
        guard let index = vehicleManager.vehicles.firstIndex(where: { $0.id == vehicle.id }) else { return }
        vehicleManager.vehicles[index].scale *= 0.9
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = VehicleManager() // Create a VehicleManager instance
        
        // Wrap MapView with environmentObject
        AccidentSituationView(presenter: AccidentsPresenter(repository: MockDataRepository()))
            .environmentObject(manager)
            .previewLayout(.sizeThatFits) // Ensure preview fits content
    }
}
