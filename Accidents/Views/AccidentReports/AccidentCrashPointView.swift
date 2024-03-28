//
//  AccidentCrashPointView.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.03.2024.
//

import SwiftUI

struct AccidentCrashPointView: View {
    
    @State private var crashPoint: CGPoint = CGPoint(x: 200, y: 200) // Initial crash point
    @State private var arrowRotation: Double = 0.0 // Arrow rotation
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Text("Indicate the points of collision with an arrow.")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                }
                Rectangle() // Background (optional)
                    .foregroundColor(.clear)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                
                Image("van")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 200)
                        .position(x: 250, y: 350)
                
                Image("car")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 150)
                        .position(x: 150, y: 350)
                
                
                DraggableArrowView(crashPoint: crashPoint, arrowRotation: arrowRotation)
                
                HStack {
                    Spacer()
                    Button(action: {
                        arrowRotation -= 5 // Rotate counter-clockwise by 5 degrees
                    }) {
                        Image(systemName: "arrowtriangle.left.fill")
                            .scaleEffect(x: 4, y: 4)
                    }
                    Spacer()
                    Button(action: {
                        arrowRotation += 5 // Rotate clockwise by 5 degrees
                    }) {
                        Image(systemName: "arrowtriangle.right.fill")
                            .scaleEffect(x: 4, y: 4)
                    }
                    Spacer()
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height - 50) // Adjust position
            }
        }
    }
    
    private func calculateVehiclePosition(geometry: GeometryProxy, type: VehicleType) -> CGPoint {
        var position = CGPoint.zero
        let padding: CGFloat = 20.0
        let vehicleGap: CGFloat = 10.0 // Space between vehicles
        
        switch type {
        case .motorcycle:
            position.x = padding
            position.y = geometry.size.height / 2
        case .car:
            position.x = padding + (60 / 3) + vehicleGap // Offset based on scaled motorcycle width
            position.y = geometry.size.height / 2
        case .van:
            position.x = padding + (60 / 3 + vehicleGap) + (100 / 3) + vehicleGap // Offset based on scaled motorcycle and car widths
            position.y = geometry.size.height / 2
        }
        
        return position
    }
}

enum VehicleType {
    case motorcycle, car, van
}

struct DraggableArrowView: View {
    
    @State private var crashPoint: CGPoint
    let arrowRotation: Double
    
    init(crashPoint: CGPoint, arrowRotation: Double) {
        self.crashPoint = crashPoint
        self.arrowRotation = arrowRotation
    }
    
    var body: some View {
        Image(systemName: "arrow.down") // Replace with your arrow image
            .resizable()
            .frame(width: 50, height: 100)
            .rotationEffect(.degrees(arrowRotation))
            .position(crashPoint)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        crashPoint = value.location // Update position on drag
                    }
            )
    }
}

#Preview {
    AccidentCrashPointView()
}
