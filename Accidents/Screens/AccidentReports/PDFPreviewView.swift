//
//  PDFPreviewView.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.11.2024.
//

import SwiftUI
import PDFKit

struct PDFPreviewView: UIViewRepresentable {
    let pdfURL: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true // Ensures the PDF scales to fit the view
        pdfView.displayMode = .singlePage
        pdfView.backgroundColor = .clear

        // Load the PDF document
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        } else {
            print("Failed to load PDF from URL: \(pdfURL)")
        }

        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Ensure the document is still loaded
        uiView.document = PDFDocument(url: pdfURL)
    }
}

struct PDFPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "Euroformular-zaznamu-o-dopravni-nehode", withExtension: "pdf") {
            PDFPreviewView(pdfURL: url)
                .frame(width: 400, height: 600) // Preview-friendly dimensions
                .clipped()
        } else {
            Text("Failed to load PDF for preview")
        }
    }
}
