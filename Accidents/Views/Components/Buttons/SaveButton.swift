//
//  SaveButton.swift
//  Accidents
//
//  Created by Marcel Mravec on 26.03.2024.
//

import SwiftUI

struct SaveButton: View {
    let label: String
    let systemImage: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label(label, systemImage: systemImage)
                .foregroundColor(.primary)
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(AccidentGradient())
                .cornerRadius(15)
        }
    }
}

#Preview {
    SaveButton(label: "Save Location", systemImage: "checkmark.circle") { }
        .padding()
}
