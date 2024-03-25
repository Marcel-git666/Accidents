//
//  ARErrorBlock.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.03.2024.
//

import SwiftUI

struct ARErrorBlock: View {
  let errorMessage: String

  var body: some View {
    RoundedRectangle(cornerRadius: 5)
      .foregroundColor(.red)
      .overlay {
        Text(errorMessage)
          .foregroundColor(.white)
      }
      .frame(maxWidth: .infinity, maxHeight: 50) 
      .padding()
  }
}

#Preview {
    ARErrorBlock(errorMessage: "My error message.")
}
