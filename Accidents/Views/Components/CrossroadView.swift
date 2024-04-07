//
//  Crossroad.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.04.2024.
//

import SwiftUI

struct CrossroadView: View {
    
    var body: some View {
        ZStack {
            VStack {
                Roundabout()
                    .stroke(Color.pink, style: StrokeStyle(lineWidth: 8))
            }
        }
    }
}

#Preview {
    CrossroadView()
}
