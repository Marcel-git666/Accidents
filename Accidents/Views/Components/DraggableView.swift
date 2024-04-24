//
//  DraggableView.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.04.2024.
//

import SwiftUI

struct DraggableView: View {
    @State private var isDragging: Bool = false
    @Binding var vehicle: Vehicle
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                vehicle.location = value.location
                self.isDragging = true
            }
            .onEnded { value in
                self.isDragging = false
            }
    }
    
    var body: some View {
        ZStack {
            Image(vehicle.imageName, bundle: nil)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .rotationEffect(vehicle.rotationAngle)
                .scaleEffect(vehicle.scale)
                .position(vehicle.location)
            
            if isDragging {
                Circle()
                    .stroke(Color.accentColor, lineWidth: 4)
                    .scaleEffect(isDragging ? 1.1 : 1.0)
                    .opacity(isDragging ? 0.7 : 0.0)
                    .animation(.easeInOut(duration: 0.5), value: isDragging)
                    .frame(width: 70, height: 70)
                    .position(vehicle.location)
                    .contentShape(Rectangle())
            }
            
        }
        .gesture(dragGesture)
    }
    
}


struct DraggableView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleVehicle = Vehicle(id: UUID().uuidString, location: CGPoint(x: 100, y: 100), imageName: "motorcycle", rotationAngle: .degrees(-15), scale: 0.8)
        
        return VStack {
            DraggableView(vehicle: .constant(sampleVehicle))
                .previewLayout(.sizeThatFits) // Ensure preview fits content
        }
    }
}

