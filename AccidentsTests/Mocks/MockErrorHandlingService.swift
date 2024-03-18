//
//  MockErrorHandlingService.swift
//  AccidentsTests
//
//  Created by Marcel Mravec on 18.03.2024.
//

import SwiftUI
@testable import Accidents

class MockErrorHandlingService: ErrorHandlingService {
  var presentErrorCalled = false
  var presentedErrorMessage: String?
  var presentingViewController: UIViewController?

  func presentError(_ error: Error, presentingViewController: UIViewController) {
    presentErrorCalled = true
    presentedErrorMessage = error.localizedDescription
    self.presentingViewController = presentingViewController
  }
}
