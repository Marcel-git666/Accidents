//
//  VisibleDamageView.swift
//  Accidents
//
//  Created by Marcel Mravec on 26.03.2024.
//

import SwiftUI

struct VisibleDamageView: View {
    @Binding var notes1: String
    @Binding var notes2: String
    let color: Color
    
    var body: some View {
        VStack {
            Text("Visible damage")
                .font(.headline)
                .padding(.bottom)
            VStack {
                TitledBorderTextField(title: "Vehicle 1", text: $notes1, placeholder: "Add some damage", titleColor: .accentColor)
                TitledBorderTextField(title: "Vehicle 2", text: $notes2, placeholder: "Add some damage", titleColor: .accentColor)
            }
        }
        .padding(.horizontal)
    }
}

struct MockVisibleDamageView: View {
    @State private var mockNotes1 = ""
    @State private var mockNotes2 = ""
    
    var body: some View {
        VisibleDamageView(notes1: $mockNotes1, notes2: $mockNotes2, color: .background)
    }
}

#Preview {
    MockVisibleDamageView()
}
