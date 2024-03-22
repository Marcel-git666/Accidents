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
            }
            .frame(width: .infinity, height: 50)
            .foregroundColor(.white)
            .padding()
    }
}

#Preview {
    ARErrorBlock(errorMessage: "My error message.")
}
