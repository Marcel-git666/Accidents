//
//  CoreDataError.swift
//  Accidents
//
//  Created by Marcel Mravec on 17.03.2024.
//

enum CoreDataError: String, Error {
    case coreDataSaveError = "There was an error saving your data to your device."
    case coreDataFetchError = "There was an error fetching your data from your device."
    case coreDataRemoveError = "There was a problem removing your report."
    case failedToFindReportToUpdate
    case coreDataUpdateError
    case decodingError = "There is a decoding error."
}
