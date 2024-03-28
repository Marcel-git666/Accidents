//
//  AccidentCrashPointView.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.03.2024.
//

import SwiftUI

struct AccidentCrashPointView: View {
    
    @State private var crashPoint: CGPoint = CGPoint(x: 200, y: 100) // Initial crash point
    @State private var arrowRotation: Double = 0.0 // Arrow rotation
    
    var body: some View {
        VStack {
            Text("Indicate the points of collision with an arrow.")
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
                            .position(x: geometry.size.width / 1.2, y: geometry.size.height / 2)
                    
                    Image("car")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 140)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    Image("motorcycle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 120)
                            .position(x: geometry.size.width / 4.5, y: geometry.size.height / 2)
                    
                    DraggableArrowView(crashPoint: crashPoint, arrowRotation: arrowRotation)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            arrowRotation -= 5
                        }) {
                            Image(systemName: "arrowtriangle.left.fill")
                                .scaleEffect(x: 4, y: 4)
                        }
                        Spacer()
                        Button(action: {
                            arrowRotation += 5
                        }) {
                            Image(systemName: "arrowtriangle.right.fill")
                                .scaleEffect(x: 4, y: 4)
                        }
                        Spacer()
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 50) 
                }
            }
            SaveButton(label: "Save picture", systemImage: "square.and.arrow.down") {
                print("Saving...")
            }
            .padding()
        }
    }
}

#Preview {
    AccidentCrashPointView()
}
