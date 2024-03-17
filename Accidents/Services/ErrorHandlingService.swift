//
//  ErrorHandlingService.swift
//  Accidents
//
//  Created by Marcel Mravec on 17.03.2024.
//

import SwiftUI

protocol ErrorHandlingService {
  func presentError(_ error: Error, presentingViewController: UIViewController)
}
