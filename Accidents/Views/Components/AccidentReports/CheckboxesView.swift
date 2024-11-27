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

    var body: some View {
        Group {
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
                .position(x: isDriverInsuredVAT ? 204 : 158, y: 272)
        }
    }
}
