//
//  ActionButtonView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.04.2024.
//

import SwiftUI

struct ActionButtonView<C: AccidentsCoordinating>: View {
    let coordinator: C

    var body: some View {
        VStack {
            Spacer()
            HStack {
                ACButton(label: "Exit and save", systemImage: "checkmark.circle") {
                    coordinator.exitAndSaveReport()
                }
                ACButton(label: "Save & Go next", systemImage: "goforward.plus") {
                    coordinator.goNext()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ActionButtonView(coordinator: MockCoordinator())
}
