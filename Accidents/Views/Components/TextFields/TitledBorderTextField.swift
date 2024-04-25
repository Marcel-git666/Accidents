//
//  TitledBorderTextField.swift
//  Accidents
//
//  Created by Marcel Mravec on 26.03.2024.
//

import SwiftUI

struct TitledBorderTextField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    let titleColor: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField(placeholder, text: $text)
                .foregroundColor(.primary)
                .padding(17)
                .border(LinearGradient(colors: [Color(UIColor.systemGray), titleColor], startPoint: .topLeading, endPoint: .top), width: 3)
            
            Text(title)
                .font(.headline)
                .foregroundColor(titleColor)
                .padding(.leading, 8)
                .padding(.trailing, 8)
                .background(Color.background)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: 24, y: -26)
    
        }
    }
}

struct MockTitledBorderTextField: View {
    @State private var text = ""
    
    var body: some View {
        TitledBorderTextField(title: "Vehicle A", text: $text, placeholder: "Add some damage", titleColor: .accentColor)
    }
}

#Preview {
    MockTitledBorderTextField()
}
