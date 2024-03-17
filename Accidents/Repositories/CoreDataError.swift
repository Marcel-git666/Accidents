//
//  CoreDataError.swift
//  Accidents
//
//  Created by Marcel Mravec on 17.03.2024.
//

enum CoreDataError: String, Error {
  case coreDataSaveError = "There was an error saving your data to your device."
  case coreDataFetchError = "There was an error fetching your data from your device."
}
