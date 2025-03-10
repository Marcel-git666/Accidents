//
//  PDFManager.swift
//  Accidents
//
//  Created by Marcel Mravec on 24.11.2024.
//

import SwiftUI
import PDFKit

class PDFManager {
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
    
    func sharePDF(_ url: URL) {
        DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            
            // Get the key window's root view controller
            if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                // For iPad: Set the popover presentation controller properties
                if let popover = activityVC.popoverPresentationController {
                    // Anchor to the center of the screen
                    popover.sourceView = rootVC.view
                    popover.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2,
                                                y: UIScreen.main.bounds.height / 2,
                                                width: 0, height: 0)
                    popover.permittedArrowDirections = [] // No arrow
                }
                
                rootVC.present(activityVC, animated: true)
            }
        }
    }
}
