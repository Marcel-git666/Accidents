//
//  PreloadDataView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct PreloadDataView: View {
    
    var body: some View {
        ZStack {
            Text("You can prefill your data here....")
            ZStack {
                Image("yellow_car")
                    .renderingMode(.template)
                    .foregroundColor(.purple)
                    .position(CGPoint(x: 200, y: 200))
                    .rotationEffect(Angle(degrees: 195), anchor: .center)
                    .scaleEffect(0.2)
                    
                Image("test")
                    .renderingMode(.template)
                    .foregroundColor(.red)
                    .position(CGPoint(x: 200, y: 200))
                    .rotationEffect(Angle(degrees: -45), anchor: .center)
                    .scaleEffect(0.2)
            }
        }
    }
}


#Preview {
    PreloadDataView()
}
