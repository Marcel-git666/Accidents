//
//  EmptyListView.swift
//  Accidents
//
//  Created by Marcel Mravec on 23.03.2024.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Image(systemName: "arrow.up.right")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .rotationEffect(.degrees(-25))
                    .padding(40)
            }
            Image(systemName: "exclamationmark.circle")
                .font(.system(size: 40))
                .foregroundColor(.gray)
            Text("No Accidents Reported Yet")
                .font(.headline)
            Text("Tap the '+' button to create a new accident report.")
                .font(.subheadline)
            Spacer()
        }
    }
}

#Preview {
    EmptyListView()
}
