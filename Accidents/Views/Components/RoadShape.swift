//
//  RoadShape.swift
//  Accidents
//
//  Created by Marcel Mravec on 06.04.2024.
//

import SwiftUI

protocol RoadShape: Shape {
    func path(in rect: CGRect) -> Path
}

struct Crossroad: RoadShape {
    
    func path(in rect: CGRect) -> Path {
        let roadWidth: CGFloat = 80
        let startPoint = CGPoint(x: rect.midX - roadWidth, y: 0)
        var path = Path()
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.midX - roadWidth, y: rect.midY - roadWidth))
        path.addLine(to: CGPoint(x: 0, y: rect.midY - roadWidth))
        path.move(to: CGPoint(x: 0, y: rect.midY + roadWidth))
        path.addLine(to: CGPoint(x: rect.midX - roadWidth, y: rect.midY + roadWidth))
        path.addLine(to: CGPoint(x: rect.midX - roadWidth, y: rect.maxY))
        path.move(to: CGPoint(x: rect.midX + roadWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + roadWidth, y: rect.midY + roadWidth))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY + roadWidth))
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY - roadWidth))
        path.addLine(to: CGPoint(x: rect.midX + roadWidth, y: rect.midY - roadWidth))
        path.addLine(to: CGPoint(x: rect.midX + roadWidth, y: 0))
        return path
    }
}

struct NormalRoad: RoadShape {
    func path(in rect: CGRect) -> Path {
        let roadWidth: CGFloat = 80
        let startPoint = CGPoint(x: rect.midX - roadWidth, y: 0)
        var path = Path()
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.midX - roadWidth, y: rect.maxY))
        path.move(to: CGPoint(x: rect.midX + roadWidth, y: 0))
        path.addLine(to: CGPoint(x: rect.midX + roadWidth, y: rect.maxY))
        return path
    }
}

struct Roundabout: RoadShape {
    func path(in rect: CGRect) -> Path {
        let roadWidth: CGFloat = 40
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2.5
        path.addRelativeArc(center: center, radius: radius, startAngle: .degrees(15), delta: .degrees(60))
        path.addLine(to: CGPoint(x: rect.midX + roadWidth, y: rect.maxY))
        path.move(to: CGPoint(x: rect.midX - roadWidth, y: rect.maxY))
        path.addRelativeArc(center: center, radius: radius, startAngle: .degrees(105), delta: .degrees(60))
        path.addLine(to: CGPoint(x: 0, y: rect.midY + roadWidth))
        path.move(to: CGPoint(x: 0, y: rect.midY - roadWidth))
        path.addRelativeArc(center: center, radius: radius, startAngle: .degrees(195), delta: .degrees(60))
        path.addLine(to: CGPoint(x: rect.midX - roadWidth, y: 0))
        path.move(to: CGPoint(x: rect.midX + roadWidth, y: 0))
        path.addRelativeArc(center: center, radius: radius, startAngle: .degrees(285), delta: .degrees(60))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY - roadWidth))
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY + roadWidth))
        path.addLine(to: CGPoint(x: rect.midX + radius * 0.95, y: rect.midY + roadWidth))
        let smallRadius = radius / 2
        path.move(to: CGPoint(x: rect.midX + smallRadius, y: rect.midY))
        path.addRelativeArc(center: center, radius: smallRadius, startAngle: .degrees(0), delta: .degrees(360))
        return path
    }
}
