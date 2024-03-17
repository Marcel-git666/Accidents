//
//  CoreDataHandlingService.swift
//  Accidents
//
//  Created by Marcel Mravec on 17.03.2024.
//

import SwiftUI

class CoreDataErrorHandlingService: ErrorHandlingService {
    func presentError(_ error: Error, presentingViewController: UIViewController) {
        if let coreDataError = error as? CoreDataError {
            presentAlert(message: coreDataError.rawValue, presentingViewController: presentingViewController)
        } else {
            // Handle other types of errors (optional)
            presentAlert(message: error.localizedDescription, presentingViewController: presentingViewController)
        }
    }
    
    private func presentAlert(message: String, presentingViewController: UIViewController) {
        let alert = UIAlertController(title: "CoreData Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        presentingViewController.present(alert, animated: true)
    }
}
