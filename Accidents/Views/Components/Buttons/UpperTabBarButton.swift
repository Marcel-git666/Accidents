//
//  UpperTabBarButton.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.03.2024.
//

import SwiftUI

struct UpperTabBarButton: View {
    let color: Color
    let systemImage: String
    let text: String
    let isActive: Bool
    
    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .foregroundColor(isActive ? color : .secondary)
                .font(.largeTitle)
                .frame(height: 50)
            Text(text)
                .font(.caption)
        }
    }
}

#Preview {
    HStack {
        UpperTabBarButton(color: .accentColor, systemImage: "airplane", text: "Location", isActive: true)
        UpperTabBarButton(color: .accentColor, systemImage: "person.fill", text: "Location", isActive: false)
        UpperTabBarButton(color: .accentColor, systemImage: "pencil.and.ruler.fill", text: "Description", isActive: true)
    }
}
