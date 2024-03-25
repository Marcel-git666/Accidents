//
//  BoolArrayTransformer.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.03.2024.
//

import Foundation
import CoreData


class BoolArrayTransformer: NSSecureUnarchiveFromDataTransformer {
  static let name = NSValueTransformerName(rawValue: String(describing: BoolArrayTransformer.self))

  override static var allowedTopLevelClasses: [AnyClass] {
    return [NSArray.self, NSMutableArray.self]
  }

  public static func register() {
    let transformer = BoolArrayTransformer()
    ValueTransformer.setValueTransformer(transformer, forName: name)
  }

  override class func transformedValueClass() -> AnyClass {
    return NSArray.self
  }

  override func transformedValue(_ value: Any?) -> Any? {
    guard let boolArray = value as? [Bool] else { return nil }
    return NSArray(array: boolArray.map { NSNumber(value: $0) })
  }

  override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard let array = value as? NSArray else { return nil }
    return (array as! [NSNumber]).map { $0.boolValue }
  }
}
