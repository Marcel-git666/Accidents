//
//  PDFManager.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.11.2024.
//

import SwiftUI
import PDFKit

final class PDFManager: @unchecked Sendable {
    static let shared = PDFManager()
    
    private init() {}
    
    @MainActor func renderPDF(with report: AccidentReport, templateImageName: String) -> URL? {
        let renderer = ImageRenderer(content: ReportPreviewView(presenter: ReportPreviewPresenter(report: report), templateImageName: templateImageName))
        
        let outputURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent("AccidentReport-\(report.id).pdf")
        
        // Ensure rendering includes background
        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            guard let pdf = CGContext(outputURL as CFURL, mediaBox: &box, nil) else { return }
            
            // Start new page with white background
            pdf.beginPDFPage(nil)
            context(pdf) // Render the SwiftUI content
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return outputURL
    }
    
    @MainActor func sharePDF(_ url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        guard let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let rootVC = windowScene.keyWindow?.rootViewController else { return }

        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = rootVC.view
            popover.sourceRect = CGRect(
                x: rootVC.view.bounds.midX,
                y: rootVC.view.bounds.midY,
                width: 0, height: 0
            )
            popover.permittedArrowDirections = []
        }

        rootVC.present(activityVC, animated: true)
    }
}
