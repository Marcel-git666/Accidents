//
//  ReportPreviewWrapper.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.11.2024.
//

import SwiftUI

struct ReportPreviewWrapper: View {
    let report: AccidentReport
    let templateImageName: String

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    // Allow tapping outside to dismiss
                }
            ScrollView([.horizontal, .vertical]) {
                ReportPreviewView(presenter: ReportPreviewPresenter(report: report), templateImageName: templateImageName)
                    .frame(width: 595.2, height: 841.8) // Match A4 dimensions
                    .background(Color.white) // Ensure a clear background
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .padding(20)
            }
        }
    }
}
