//
//  AccidentListItemView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentListItemView: View {
    let accident: AccidentReport
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: accident.accidentLocation.date)
    }
    
    var formattedPlace: String {
        return "\(accident.accidentLocation.city), \(accident.accidentLocation.street)"
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(accident.driver.name)
                Text(formattedDate)
            }
            VStack(alignment: .leading) {
                Text(accident.otherDriver?.name ?? "No driver")
                Text(formattedPlace)
            }
        }
    }
}

#Preview {
    AccidentListItemView(accident: AccidentReport.sampleData)
        .padding()
}
