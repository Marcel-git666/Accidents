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
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @GestureState private var magnificationState: CGFloat = 1.0
    @GestureState private var dragState: CGSize = .zero
    
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
                    .scaleEffect(scale)
                    .offset(x: offset.width + dragState.width, y: offset.height + dragState.height)
                // Combine gestures for zoom and pan
                    .gesture(
                        DragGesture()
                            .updating($dragState) { value, state, _ in
                                // Only allow dragging when zoomed in
                                if scale > 1.0 {
                                    state = value.translation
                                }
                            }
                            .onEnded { value in
                                // Only update offset when zoomed in
                                if scale > 1.0 {
                                    offset = CGSize(
                                        width: offset.width + value.translation.width,
                                        height: offset.height + value.translation.height
                                    )
                                    lastOffset = offset
                                }
                            }
                    )
                    .gesture(
                        MagnificationGesture()
                            .updating($magnificationState) { currentState, gestureState, _ in
                                gestureState = currentState
                            }
                            .onChanged { value in
                                let delta = value / lastScale
                                lastScale = value
                                
                                // Limit zoom range between 0.5x and 4x
                                let newScale = scale * delta
                                scale = min(max(newScale, 0.5), 4.0)
                            }
                            .onEnded { _ in
                                lastScale = 1.0
                            }
                    )
            }
            .gesture(
                // Double tap to reset zoom and position
                TapGesture(count: 2)
                    .onEnded {
                        withAnimation {
                            scale = 1.0
                            offset = .zero
                        }
                    }
            )
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        withAnimation {
                            scale = max(scale - 0.25, 0.5)
                        }
                    }) {
                        Image(systemName: "minus.magnifyingglass")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            scale = 1.0 // Reset to original size
                        }
                    }) {
                        Image(systemName: "1.magnifyingglass")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            scale = min(scale + 0.25, 4.0)
                        }
                    }) {
                        Image(systemName: "plus.magnifyingglass")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
                .padding()
            }
        }
    }
}
