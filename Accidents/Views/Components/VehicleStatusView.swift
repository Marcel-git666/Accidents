//
//  VehicleStatusView.swift
//  Accidents
//
//  Created by Marcel Mravec on 26.03.2024.
//

import SwiftUI

struct VehicleStatusView: View {
    let vehicleStatusDescription: String
    @Binding var isSelected1: Bool
    @Binding var isSelected2: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            TickBox(text: "", isSelected: $isSelected1)
            Spacer()
            Text(vehicleStatusDescription)
            Spacer()
            TickBox(text: "", isSelected: $isSelected2)
        }
        .padding(.horizontal)
    }
}


struct MockVehicleStatusView: View {
    @State private var isSelected1 = false
    @State private var isSelected2 = true

    var body: some View {
        VehicleStatusView(vehicleStatusDescription: "was parking", isSelected1: $isSelected1, isSelected2: $isSelected2)
        VehicleStatusView(vehicleStatusDescription: "Rear-ended while driving in the same direction and lane", isSelected1: $isSelected1, isSelected2: $isSelected2)
    }
}

#Preview {
    MockVehicleStatusView()
}
