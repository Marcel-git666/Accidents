//
//  AccidentSituationView.swift
//  Accidents
//

import SwiftUI

struct AccidentSituationView: View {
    @Bindable var model: SituationFormModel
    @State private var selectedVehicle: Vehicle?

    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.4)
                .ignoresSafeArea()
            RoadShapeView(roadShape: model.roadShape)
                .padding(.vertical, 50)

            VStack {
                VehicleButtonView(model: model)
                HStack {
                    ControlButtonView(
                        roadShape: $model.roadShape,
                        model: model,
                        selectedVehicle: $selectedVehicle)
                    Spacer()
                }
                Spacer()
            }
            .padding(.top)

            ForEach($model.vehicles) { $vehicle in
                DraggableView(vehicle: $vehicle)
                    .onTapGesture {
                        selectedVehicle = vehicle
                    }
            }

            RotationButtoView(model: model, selectedVehicle: $selectedVehicle)
            ScaleButtonView(model: model, selectedVehicle: $selectedVehicle)
        }
    }
}

#Preview {
    let model = SituationFormModel()
    model.load(from: AccidentSituation(
        roadShape: .crossroad,
        vehicles: [
            Vehicle(id: UUID().uuidString, location: CGPoint(x: 100, y: 100), imageName: "blueCar", rotationAngle: Angle(degrees: 30), scale: 1),
            Vehicle(id: UUID().uuidString, location: CGPoint(x: 200, y: 200), imageName: "yellowCar", rotationAngle: Angle(degrees: -45), scale: 1),
            Vehicle(id: UUID().uuidString, location: CGPoint(x: 150, y: 150), imageName: "bike", rotationAngle: Angle(degrees: 90), scale: 1)
        ]
    ))
    return AccidentSituationView(model: model)
}
