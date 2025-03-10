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
            Color.black
                .ignoresSafeArea()
                .onTapGesture {
                    // Allow tapping outside to dismiss
                }
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                ReportPreviewView(presenter: ReportPreviewPresenter(report: report), templateImageName: templateImageName)
                    .frame(width: 595.2 * scale, height: 841.8 * scale) // Scale dimensions
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .padding(20)
                    .offset(x: offset.width + dragState.width, y: offset.height + dragState.height)
                // Use a gesture group to manage both pan and zoom
                    .gesture(
                        SimultaneousGesture(
                            // Pan gesture
                            DragGesture()
                                .updating($dragState) { value, state, _ in
                                    state = value.translation
                                }
                                .onEnded { value in
                                    offset = CGSize(
                                        width: offset.width + value.translation.width,
                                        height: offset.height + value.translation.height
                                    )
                                },
                            // Zoom gesture
                            MagnificationGesture()
                                .updating($magnificationState) { currentState, gestureState, _ in
                                    gestureState = currentState
                                }
                                .onChanged { value in
                                    let delta = value / lastScale
                                    lastScale = value

                                    // Limit zoom range
                                    let newScale = scale * delta
                                    scale = min(max(newScale, 0.5), 4.0)
                                }
                                .onEnded { _ in
                                    lastScale = 1.0
                                }
                        )
                    )
            }
            // Double tap to reset
            .contentShape(Rectangle())
            .onTapGesture(count: 2) {
                withAnimation {
                    scale = 1.0
                    offset = .zero
                }
            }

            // Control buttons
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
                            offset = .zero // Reset position
                        }
                    }) {
                        Image(systemName: "arrow.counterclockwise")
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
