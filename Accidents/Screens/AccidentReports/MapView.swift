import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var vehicleManager: VehicleManager
    @State private var roadShapeSelector: RoadShapeSelector = .normalRoad
    @State private var selectedVehicle: Vehicle? = nil
    @State private var rotationAngle: Angle = .degrees(0)
    @State private var scaleValue: CGFloat = 1.0
    
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
                    Roundabout()
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
                        roadShapeSelector = .roundabout
                    } label: {
                        Text("Roundabout")
                    }
                }
                HStack {
                    Button {
                        vehicleManager.addVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.car) // Add car at origin (adjust location)
                    } label: {
                        Text("Car")
                    }
                    Button {
                        vehicleManager.addVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.van)
                    } label: {
                        Text("Van")
                    }
                    Button {
                        vehicleManager.addVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.yellowMotorcycle)
                    } label: {
                        Text("Y-M")
                    }
                    Button {
                        vehicleManager.addVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.blueMotorcycle)
                    } label: {
                        Text("B-M")
                    }
                    Button {
                        vehicleManager.addVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.yellowCar)
                    } label: {
                        Text("Y-C")
                    }
                    Button {
                        vehicleManager.addVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.blueCar)
                    } label: {
                        Text("B-C")
                    }
                    Button {
                        vehicleManager.addVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.yellowVan)
                    } label: {
                        Text("Y-V")
                    }
                    Button {
                        vehicleManager.addVehicle(location: CGPoint(x: 100, y: 100), imageName: K.Images.blueVan)
                    } label: {
                        Text("B-M")
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
                
                HStack {
                    Button("Clear All") {
                        vehicleManager.vehicles.removeAll()
                    }
                    Button("Remove Selected") {
                        if let selectedVehicle = selectedVehicle {
                            vehicleManager.removeVehicle(withId: selectedVehicle.id)
                            self.selectedVehicle = nil
                        }
                    }
                }
            }
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
        MapView()
            .environmentObject(manager)
            .previewLayout(.sizeThatFits) // Ensure preview fits content
    }
}
