//
//  PDFPreviewContainer.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.11.2024.
//

import SwiftUI
import PDFKit

struct PDFPreviewContainer: View {
    let pdfURL: URL

    var body: some View {
        VStack {
            // PDF Viewer
            PDFPreviewView(pdfURL: pdfURL)

            // Share Button
            Button(action: {
                PDFManager.shared.sharePDF(pdfURL)
            }) {
                Label("Share PDF", systemImage: "square.and.arrow.up")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}

struct PDFPreviewContainer_Previews: PreviewProvider {
    static var previews: some View {
        // Load a sample PDF from the app bundle
        if let sampleURL = Bundle.main.url(forResource: "Euroformular-zaznamu-o-dopravni-nehode", withExtension: "pdf") {
            PDFPreviewContainer(pdfURL: sampleURL)
                .frame(width: 400, height: 600) // Adjust frame size for preview
        } else {
            Text("Failed to load PDF for preview")
        }
    }
}

