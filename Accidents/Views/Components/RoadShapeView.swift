//
//  RoadShapeView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.04.2024.
//

import SwiftUI

struct RoadShapeView: View {
    let roadShape: RoadShapeSelector
    var body: some View {
        VStack {
            switch roadShape {
            case .crossroad:
                Crossroad()
                    .stroke(Color.pink, style: StrokeStyle(lineWidth: 8))
            case .normalRoad:
                NormalRoad()
                    .stroke(Color.pink, style: StrokeStyle(lineWidth: 8))
            case .roundabout:
                Roundabout()
                    .stroke(Color.pink, style: StrokeStyle(lineWidth: 8))
            }
        }
    }
}

struct RoadShapeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack(spacing: 20) {
                Spacer()
                UpperTabBarButton(color: .accent, systemImage: "book", text: "something", isActive: true)
                Spacer()
            }
            .background(Color.gray.opacity(0.4))
            .padding()
            
            TabView {
                RoadShapeView(roadShape: .roundabout)
                    .tabItem {
                        Label("Road Shape", systemImage: "cross")
                    }
                
            }
        }
    }
}
