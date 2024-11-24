//
//  PDFManager.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.11.2024.
//

import PDFKit

class PDFGenerator {
    func generatePDF(for report: AccidentReport, templateURL: URL) -> URL? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputURL = documentsURL.appendingPathComponent("AccidentReport-\(report.id).pdf")

//        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("AccidentReport-\(report.id).pdf")
        
        guard let templatePDF = PDFDocument(url: templateURL) else { return nil }
        
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595.2, height: 841.8)) // A4 size
        
        do {
            try renderer.writePDF(to: outputURL) { context in
                context.beginPage()
                
                // Draw template page
                if let page = templatePDF.page(at: 0)?.pageRef {
                    let pdfContext = context.cgContext
                    
                    // Save the current graphics state
                    pdfContext.saveGState()
                    
                    // Flip the context vertically
                    pdfContext.translateBy(x: 0, y: context.pdfContextBounds.height)
                    pdfContext.scaleBy(x: 1.0, y: -1.0)
                    
                    // Draw the PDF page
                    pdfContext.drawPDFPage(page)
                    
                    // Restore the graphics state
                    pdfContext.restoreGState()
                    // Overlay accident data
                    let attributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 14),
                        .foregroundColor: UIColor.black
                    ]
                    let smallAttributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 10),
                        .foregroundColor: UIColor.black
                    ]
                    
                    let largeAttributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.boldSystemFont(ofSize: 18),
                        .foregroundColor: UIColor.red
                    ]
                    let arrowPosition = CGPoint(x: 200, y: 600) // Adjust based on your PDF layout
                    let arrowRotation = CGFloat(report.pointOfImpact1?.arrowRotation ?? 0) * .pi / 180
                    let arrowScale = report.pointOfImpact1?.scale ?? 1.0
                    
                    drawSFArrow(context: pdfContext, position: arrowPosition, rotation: arrowRotation, scale: arrowScale)
                    
                    let streetNumber = report.accidentLocation.street + " " + report.accidentLocation.houseNumber + " "
                    + report.accidentLocation.city + " "
                    streetNumber.draw(at: CGPoint(x: 180, y: 100), withAttributes: attributes)
                    report.accidentLocation.date.description.draw(at: CGPoint(x: 65, y: 100), withAttributes: attributes)
                    if report.accidentLocation.injuries == true {
                        "x".draw(at: CGPoint(x: 500, y: 99), withAttributes: attributes)
                    } else {
                        "x".draw(at: CGPoint(x: 453, y: 99), withAttributes: attributes)
                    }
                    if report.accidentLocation.policeInvolved == true {
                        
                    }
                }
                
            }
            
            return outputURL
            
        } catch {
            print("Error generating PDF: \(error)")
            return nil
        }
    }
    
    private func drawSFArrow(context: CGContext, position: CGPoint, rotation: Double, scale: CGFloat) {
        context.saveGState()
        
        // Apply transformations for position, rotation, and scaling
        context.translateBy(x: position.x, y: position.y)
        context.rotate(by: CGFloat(rotation * .pi / 180)) // Convert degrees to radians
        context.scaleBy(x: scale, y: scale)
        
        // Load the SF Symbol as a UIImage
        if let arrowImage = UIImage(systemName: "arrow.down")?.cgImage {
            let rect = CGRect(x: -25, y: -50, width: 50, height: 100) // Center the arrow at its tip
            context.draw(arrowImage, in: rect)
        } else {
            print("Failed to load SF Symbol arrow.down")
        }
        
        context.restoreGState()
    }
    
    func drawArrow(context: CGContext, position: CGPoint, rotation: CGFloat, scale: CGFloat) {
        context.saveGState()
        
        // Apply transformations for rotation and scaling
        context.translateBy(x: position.x, y: position.y)
        context.rotate(by: rotation)
        context.scaleBy(x: scale, y: scale)
        
        // Define the arrow path
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 0))    // Arrow tip
        context.addLine(to: CGPoint(x: -10, y: -20)) // Left base
        context.addLine(to: CGPoint(x: 10, y: -20))  // Right base
        context.closePath()
        
        // Fill the arrow
        context.setFillColor(UIColor.black.cgColor)
        context.fillPath()
        
        // Restore the graphics state
        context.restoreGState()
    }
    
}
