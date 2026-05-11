//
//  AccidentCrashPointView.swift
//  Accidents
//

import SwiftUI

struct AccidentCrashPointView: View {
    @Bindable var model: ImpactFormModel
    let isVehicleA: Bool

    @State private var vanPosition: CGPoint = CGPoint(x: 300, y: 220)
    @State private var carPosition: CGPoint = CGPoint(x: 180, y: 220)
    @State private var motorcyclePosition: CGPoint = CGPoint(x: 80, y: 220)

    var body: some View {
        VStack {
            Text("Indicate the point of collision for Vehicle \(isVehicleA ? "A" : "B").")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            GeometryReader { geometry in
                ZStack {
                    Image("van")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 200)
                        .position(vanPosition)

                    Image("car")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 140)
                        .position(carPosition)

                    Image("motorcycle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 120)
                        .position(motorcyclePosition)

                    DraggableArrowView()
                        .rotationEffect(.degrees(model.arrowRotation), anchor: .bottom)
                        .scaleEffect(model.scale)
                        .position(model.crashPoint)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    model.crashPoint = value.location
                                }
                        )
                        .gesture(MagnifyGesture()
                            .onChanged { value in
                                if value.magnification > 0.5 && value.magnification < 1.7 {
                                    model.scale = value.magnification
                                }
                            }
                        )

                    HStack {
                        Spacer()
                        Button {
                            model.arrowRotation -= 15
                        } label: {
                            Image(systemName: "arrowtriangle.left.fill")
                                .scaleEffect(x: 3, y: 3)
                        }
                        Spacer()
                        Button {
                            model.arrowRotation += 15
                        } label: {
                            Image(systemName: "arrowtriangle.right.fill")
                                .scaleEffect(x: 3, y: 3)
                        }
                        Spacer()
                        Button {
                            if model.scale < 1.7 { model.scale += 0.25 }
                        } label: {
                            Image(systemName: "arrowtriangle.up.fill")
                                .foregroundColor(.accentColor)
                                .scaleEffect(CGSize(width: 3, height: 3))
                        }
                        Spacer()
                        Button {
                            if model.scale > 0.4 { model.scale -= 0.25 }
                        } label: {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(.accentColor)
                                .scaleEffect(CGSize(width: 3, height: 3))
                        }
                        Spacer()
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                model.reset()
                            }
                        } label: {
                            Image(systemName: "arrow.uturn.backward")
                                .foregroundColor(.accentColor)
                                .scaleEffect(CGSize(width: 3, height: 3))
                        }
                        Spacer()
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 50)
                }
                .contentShape(Rectangle())
            }
        }
    }
}

#Preview {
    AccidentCrashPointView(model: ImpactFormModel(), isVehicleA: true)
}
