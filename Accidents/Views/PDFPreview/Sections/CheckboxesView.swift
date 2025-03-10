//
//  CheckboxesView.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.11.2024.
//

import SwiftUI

struct CheckboxesView: View {
    let isInjuriesChecked: Bool
    let isPoliceInvolved: Bool
    let isOtherDamage: Bool
    let isDriverInsuredVAT: Bool
    let hasComprehensiveInsurance: Bool
    let vehicle1Damage: [Bool]
    let vehicle2Damage: [Bool]
    let totalHeight: CGFloat = 323 // Total vertical space available
    
    var body: some View {
        // Calculate spacing dynamically within the body
        let spacingVehicle1 = vehicle1Damage.count > 1 ? totalHeight / CGFloat(vehicle1Damage.count - 1) : 0
        let spacingVehicle2 = vehicle2Damage.count > 1 ? totalHeight / CGFloat(vehicle2Damage.count - 1) : 0
        let totalVehicle1Damage = vehicle1Damage.filter { $0 }.count
        let totalVehicle2Damage = vehicle2Damage.filter { $0 }.count
        
        return Group {
            // Static Checkboxes
            Text("x")
                .font(.system(size: 12))
                .position(x: isInjuriesChecked ? 504 : 456, y: 108)
            Text("x")
                .font(.system(size: 12))
                .position(x: isPoliceInvolved ? 504 : 456, y: 141)
            Text("x")
                .font(.system(size: 12))
                .position(x: isOtherDamage ? 146 : 99, y: 146)
            Text("x")
                .font(.system(size: 12))
                .position(x: hasComprehensiveInsurance ? 204 : 158, y: 452)

            // Dynamic Checkboxes for Vehicle 1 Damage
            ForEach(0..<vehicle1Damage.count, id: \.self) { index in
                if vehicle1Damage[index] {
                    Text("x")
                        .font(.system(size: 12))
                        .position(x: 222, y: 206 + round(spacingVehicle1 * CGFloat(index)))
                }
            }

            // Dynamic Checkboxes for Vehicle 2 Damage
            ForEach(0..<vehicle2Damage.count, id: \.self) { index in
                if vehicle2Damage[index] {
                    Text("x")
                        .font(.system(size: 12))
                        .position(x: 371, y: 206 + round(spacingVehicle2 * CGFloat(index)))
                }
            }
            
            Text("\(totalVehicle1Damage)")
                .font(.system(size: 9.5))
                .position(x: 222, y: 206 + totalHeight + 26)
            Text("\(totalVehicle2Damage)")
                .font(.system(size: 9.5))
                .position(x: 371, y: 206 + totalHeight + 26)
        }
    }
}
