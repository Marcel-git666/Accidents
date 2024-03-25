//
//  TickBox.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.03.2024.
//

import SwiftUI

struct TickBox: View {
    let text: String
    @Binding var isSelected: Bool
    let frameColor: Color
    
    var body: some View {
        Toggle(isOn: $isSelected) {
            Text(text)
        }
        .toggleStyle(iOSCheckboxToggleStyle())
        .frame(maxWidth: 150, minHeight: 52)
        .overlay(Rectangle().stroke(lineWidth: 3).foregroundColor(frameColor))
    }
}


#Preview {
    Group {
        // Preview showing "yes" selected
        TickBox(text: "yes", isSelected: .constant(true), frameColor: .primary)
        
        // Preview showing "no" selected (using constant binding)
        TickBox(text: "no", isSelected: .constant(false), frameColor: .clear)
    }
}
