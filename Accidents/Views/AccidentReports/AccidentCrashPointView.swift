//
//  AccidentCrashPointView.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.03.2024.
//

import SwiftUI

struct AccidentCrashPointView: View {
    @ObservedObject var presenter: AccidentsPresenter
    @State private var crashPoint: CGPoint = CGPoint(x: 200, y: 100)
    @State private var arrowRotation: Double = 0.0
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Text("Indicate the point of collision for Vehicle \(presenter.selectedTab == .pointOfImpact1 ? "A" : "B").")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            GeometryReader { geometry in
                ZStack {
                    Image("van")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 200)
                        .position(x: geometry.size.width / 1.2, y: geometry.size.height / 2)
                    
                    Image("car")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 140)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    Image("motorcycle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 120)
                        .position(x: geometry.size.width / 4.5, y: geometry.size.height / 2)
                    
                    DraggableArrowView(crashPoint: crashPoint, scale: scale, arrowRotation: arrowRotation)
                        .rotationEffect(.degrees(arrowRotation), anchor: .bottom)
                        .scaleEffect(scale)
                        .position(crashPoint)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    crashPoint = value.location
                                }
                        )
                        .gesture(MagnifyGesture()
                            .onChanged({ value in
                                if value.magnification > 0.5 {
                                    scale = value.magnification
                                }
                            })
                        )
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            arrowRotation -= 15
                        }) {
                            Image(systemName: "arrowtriangle.left.fill")
                                .scaleEffect(x: 3, y: 3)
                        }
                        Spacer()
                        Button(action: {
                            arrowRotation += 15
                        }) {
                            Image(systemName: "arrowtriangle.right.fill")
                                .scaleEffect(x: 3, y: 3)
                        }
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                crashPoint = CGPoint(x: 200, y: 100)
                                arrowRotation = 0
                                scale = 1.0
                            }
                        }) {
                            Image(systemName: "arrow.uturn.backward")
                                .foregroundColor(.accentColor)
                                .scaleEffect(CGSize(width: 3, height: 3))
                        }
                        Spacer()
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 50)
                }
            }
            HStack {
                SaveButton(label: "Save picture", systemImage: "square.and.arrow.down") {
                     presenter.goNext()
                }
                .padding()
            }
        }
    }
}

#Preview {
    AccidentCrashPointView(presenter: MockPresenter(repository: MockDataRepository()))
}
