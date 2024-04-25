//
//  iOSCheckboxToggleStyle.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.03.2024.
//

import SwiftUI

struct IOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                configuration.label
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
            }
            .foregroundColor(configuration.isOn ? .accentColor : .secondary) 
        }
        .contentShape(Rectangle())
    }
}
