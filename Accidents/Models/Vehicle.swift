//
//  Vehicle.swift
//  Accidents
//
//  Created by Marcel Mravec on 07.04.2024.
//

import Foundation

struct Vehicle: Identifiable {
  let id: String = UUID().uuidString 
  var location: CGPoint
  let imageName: String
}
