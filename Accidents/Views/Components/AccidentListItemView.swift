//
//  AccidentListItemView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct AccidentListItemView: View {
    @Binding var report: AccidentReport
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: report.accidentLocation.date)
    }
    
    var formattedPlace: String {
        return "\(report.accidentLocation.city), \(report.accidentLocation.street)"
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(report.driver.insuredName)
                    .font(.headline)
                Text(formattedDate)
            }
            VStack(alignment: .leading) {
                Text(report.otherDriver?.insuredName ?? "No driver")
                    .font(.headline)
                Text(formattedPlace)
            }
        }
        .foregroundColor(report.accidentLocation.injuries ? .red : .primary)
    }
}

#Preview {
    AccidentListItemView(report: Binding<AccidentReport>(get: { AccidentReport.sampleData }, set: { _ in }))
        .padding()
}
