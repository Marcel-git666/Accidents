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
    
    var body: some View {
        Toggle(isOn: $isSelected) {
            Text(text)
        }
        .toggleStyle(IOSCheckboxToggleStyle())
        
    }
}

#Preview {
    Group {
        // Preview showing "yes" selected
        TickBox(text: "yes", isSelected: .constant(true))
        
        // Preview showing "no" selected (using constant binding)
        TickBox(text: "no", isSelected: .constant(false))
    }
}
