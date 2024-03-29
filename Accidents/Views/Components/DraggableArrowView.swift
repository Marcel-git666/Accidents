//
//  DraggableArrowView.swift
//  Accidents
//
//  Created by Marcel Mravec on 28.03.2024.
//

import SwiftUI

struct DraggableArrowView: View {
    
    let crashPoint: CGPoint
    let scale: CGFloat
    let arrowRotation: Double
    
    init(crashPoint: CGPoint, scale: Double, arrowRotation: Double) {
        self.crashPoint = crashPoint
        self.scale = scale
        self.arrowRotation = arrowRotation
    }
    
    var body: some View {
        Image(systemName: "arrow.down") 
            .resizable()
            .frame(width: 50, height: 100)
            
    }
}


#Preview {
    DraggableArrowView(crashPoint: CGPoint(x: 200, y: 200), scale: 1, arrowRotation: 45)
}
