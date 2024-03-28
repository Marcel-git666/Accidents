//
//  DraggableArrowView.swift
//  Accidents
//
//  Created by Marcel Mravec on 28.03.2024.
//

import SwiftUI

struct DraggableArrowView: View {
    
    @State private var crashPoint: CGPoint
    let arrowRotation: Double
    
    init(crashPoint: CGPoint, arrowRotation: Double) {
        self.crashPoint = crashPoint
        self.arrowRotation = arrowRotation
    }
    
    var body: some View {
        Image(systemName: "arrow.down") 
            .resizable()
            .frame(width: 50, height: 100)
            .rotationEffect(.degrees(arrowRotation))
            .position(crashPoint)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        crashPoint = value.location
                    }
            )
    }
}


#Preview {
    DraggableArrowView(crashPoint: CGPoint(x: 200, y: 200), arrowRotation: 45)
}
