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
    @State private var noInjury = false
    
  var body: some View {
    VStack {
      Text(question)
      HStack {
          TickBox(text: "yes", isSelected: $injury, frameColor: .primary)
          TickBox(text: "no", isSelected: $noInjury, frameColor: .primary)
      }
      .onChange(of: injury) { newValue in
          if newValue {
              noInjury = false
          }
      }
      .onChange(of: noInjury) { newValue in
          if newValue {
              injury = false
          }
      }
      .onAppear() {
          noInjury = !injury
      }
    }
  }
}





#Preview {
    YesNoView(question: "Injuries?", injury: .constant(true)) // Constant binding (limited)
}
