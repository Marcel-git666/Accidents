//
//  YesNoView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.03.2024.
//

import SwiftUI

struct YesNoView: View {
    let question: String
    @Binding var injury: Bool
    
    
  var body: some View {
    VStack {
      Text(question)
      HStack {
        TickBox(text: "yes", isSelected: $injury) // Bind to selection state
          TickBox(text: "no", isSelected: .constant(!injury))
      }
    }
  }
}





#Preview {
  YesNoView(question: "Injuries?", injury: .constant(false)) // Constant binding (limited)
}
