//
//  WitnessesView.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.11.2024.
//

import SwiftUI

struct WitnessesView: View {
    let witnesses: [String]

    var body: some View {
        Group {
            Text(witnesses.first ?? "no witnesses")
                .font(.system(size: 10))
                .frame(width: 200, height: 12, alignment: .leading)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .position(x: 285, y: 140)

            if witnesses.count > 1 {
                Text(witnesses[1])
                    .font(.system(size: 10))
                    .frame(width: 200, height: 12, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .truncationMode(.tail)
                    .position(x: 285, y: 150)
            }

            if witnesses.count > 2 {
                Text("...")
                    .font(.system(size: 10))
                    .frame(width: 200, height: 8, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .position(x: 285, y: 155)
            }
        }
    }
}
