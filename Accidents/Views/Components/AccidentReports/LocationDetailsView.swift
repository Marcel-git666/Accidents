//
//  LocationDetailsView.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.11.2024.
//

import SwiftUI

struct LocationDetailsView: View {
    let city: String
    let street: String
    let houseNumber: String

    var body: some View {
        Text("\(city), \(street) \(houseNumber)")
            .font(.system(size: 12))
            .frame(width: 200, height: 20, alignment: .leading)
            .multilineTextAlignment(.leading)
            .truncationMode(.tail)
            .position(x: 285, y: 113)
    }
}
