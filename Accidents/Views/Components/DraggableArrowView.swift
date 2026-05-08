//
//  DraggableArrowView.swift
//  Accidents
//
//  Created by Marcel Mravec on 28.03.2024.
//

import SwiftUI

struct DraggableArrowView: View {
    var body: some View {
        Image(systemName: "arrow.down")
            .resizable()
            .frame(width: 50, height: 100)
    }
}

#Preview {
    DraggableArrowView()
}
