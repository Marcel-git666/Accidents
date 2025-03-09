//
//  AccidentCrashPointView.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.03.2024.
//

import SwiftUI

struct AccidentCrashPointView: View {
    @ObservedObject var presenter: AccidentsPresenter
    @Binding var pointOfImpact: PointOfImpact
    
    @State private var vanPosition: CGPoint = CGPoint(x: 300, y: 220)
    @State private var carPosition: CGPoint = CGPoint(x: 180, y: 220)
    @State private var motorcyclePosition: CGPoint = CGPoint(x: 80, y: 220)
    
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
                        .position(vanPosition)
                    
                    Image("car")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 140)
                        .position(carPosition)
                    Image("motorcycle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 120)
                        .position(motorcyclePosition)
                    
                    DraggableArrowView(crashPoint: pointOfImpact.crashPoint, scale: pointOfImpact.scale, arrowRotation: pointOfImpact.arrowRotation)
                        .rotationEffect(.degrees(pointOfImpact.arrowRotation), anchor: .bottom)
                        .scaleEffect(pointOfImpact.scale)
                        .position(pointOfImpact.crashPoint)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    pointOfImpact.crashPoint = value.location
                                }
                        )
                        .gesture(MagnifyGesture()
                            .onChanged({ value in
                                if value.magnification > 0.5 && value.magnification < 1.7 {
                                    pointOfImpact.scale = value.magnification
                                }
                            })
                        )
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            pointOfImpact.arrowRotation -= 15
                        }, label: {
                            Image(systemName: "arrowtriangle.left.fill")
                                .scaleEffect(x: 3, y: 3)
                        })
                        Spacer()
                        Button(action: {
                            pointOfImpact.arrowRotation += 15
                        }, label: {
                            Image(systemName: "arrowtriangle.right.fill")
                                .scaleEffect(x: 3, y: 3)
                        })
                        Spacer()
                        
                        Button(action: {
                            if pointOfImpact.scale < 1.7 {
                                pointOfImpact.scale += 0.25
                            }
                        }, label: {
                            Image(systemName: "arrowtriangle.up.fill")
                                .foregroundColor(.accentColor)
                                .scaleEffect(CGSize(width: 3, height: 3))
                        })
                        Spacer()
                        Button(action: {                   
                            if pointOfImpact.scale > 0.4 {
                                pointOfImpact.scale -= 0.25
                            }
                        }, label: {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(.accentColor)
                                .scaleEffect(CGSize(width: 3, height: 3))
                        })
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                pointOfImpact.crashPoint = CGPoint(x: 200, y: 100)
                                pointOfImpact.arrowRotation = 0
                                pointOfImpact.scale = 1.0
                            }
                        }, label: {
                            Image(systemName: "arrow.uturn.backward")
                                .foregroundColor(.accentColor)
                                .scaleEffect(CGSize(width: 3, height: 3))
                        })
                        Spacer()
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 50)
                }
                .contentShape(Rectangle())
            }
//            HStack {
//                ACButton(label: "Exit and save", systemImage: "checkmark.circle") {
//                    presenter.createReportAndSave()
//                }
//                ACButton(label: "Save & Go next", systemImage: "goforward.plus") {
//                        presenter.goNext()
//                }
//            }
        }
    }
    
}

struct AccidentCrashPointView_Previews: PreviewProvider {
  static var previews: some View {
    let pointOfImpact = PointOfImpact(crashPoint: CGPoint(x: 200, y: 100), arrowRotation: 45, scale: 0.9)
    return AccidentCrashPointView(presenter: AccidentsPresenter(repository: MockDataRepository()), pointOfImpact: { () -> Binding<PointOfImpact> in
      return Binding<PointOfImpact>(get: { pointOfImpact }, set: { _ in
      })
    }())
  }
}
