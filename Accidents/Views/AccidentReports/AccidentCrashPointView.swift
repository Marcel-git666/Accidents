//
//  AccidentCrashPointView.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.03.2024.
//

import SwiftUI

struct AccidentCrashPointView: View {
    
    @State private var crashPoint: CGPoint = CGPoint(x: 100, y: 100) // Initial crash point
    @State private var arrowRotation: Double = 0.0 // Arrow rotation
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle() // Background (optional)
                    .foregroundColor(.clear)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                // Vehicles (scaled down 1/3)
                Image("motorcycle") 
                        .resizable()
                        .frame(width: 80, height: 200)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 60 / 3, height: 330 / 3)
                    .position(calculateVehiclePosition(geometry: geometry, type: .motorcycle))
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100 / 3, height: 400 / 3)
                    .position(calculateVehiclePosition(geometry: geometry, type: .car))
                
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 120 / 3, height: 450 / 3)
                    .position(calculateVehiclePosition(geometry: geometry, type: .van))
                
                DraggableArrowView(crashPoint: crashPoint, arrowRotation: arrowRotation)
                
                HStack {
                    Button(action: {
                        arrowRotation -= 5 // Rotate counter-clockwise by 5 degrees
                    }) {
                        Image(systemName: "arrowtriangle.left.fill") // Replace with icon
                    }
                    Button(action: {
                        arrowRotation += 5 // Rotate clockwise by 5 degrees
                    }) {
                        Image(systemName: "arrowtriangle.right.fill") // Replace with icon
                    }
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
