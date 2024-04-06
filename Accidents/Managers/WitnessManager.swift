//
//  WitnessManager.swift
//  Accidents
//
//  Created by Marcel Mravec on 06.04.2024.
//

import Foundation

class WitnessManager: ObservableObject {
  @Published var witnesses: [Witness] = []

  func updateWitness(at index: Int, with newValue: Witness) {
    witnesses[index] = newValue
  }
}
