//
//  PDFCheckbox.swift
//  Accidents
//
//  Created by Marcel Mravec on 10.03.2025.
//

import SwiftUI

struct PDFCheckbox: View {
    let position: CGPoint

    var body: some View {
        Text("X")
            .font(.system(size: 14, weight: .bold))
            .position(position)
    }
}

#Preview {
    PDFCheckbox(position: CGPoint(x: 100, y: 100))
}
