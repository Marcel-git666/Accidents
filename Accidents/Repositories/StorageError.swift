//
//  CoreDataError.swift
//  Accidents
//
//  Created by Marcel Mravec on 17.03.2024.
//

import Foundation

enum StorageError: Error, LocalizedError {
    case saveError
    case fetchError
    case removeError
    case updateError
    
    var errorDescription: String? {
        switch self {
        case .saveError:
            return "There was an error saving your data to your device."
        case .fetchError:
            return "There was an error fetching your data from your device."
        case .removeError:
            return "There was a problem removing your report."
        case .updateError:
            return "There was a problem updating your report."
        }
    }
}
