//
//  AccidentGradient.swift
//  Accidents
//
//  Created by Marcel Mravec on 29.03.2024.
//

import SwiftUI

struct AccidentGradient: View {
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    let opacity: Double
    
    init(colors: [Color] = [.blue, .accentColor], startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing, opacity: Double = 0.8) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.opacity = opacity
    }
    
    var body: some View {
        LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint)
            .opacity(opacity)
    }
}

#Preview {
    AccidentGradient()
}
