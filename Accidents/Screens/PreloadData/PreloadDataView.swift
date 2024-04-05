//
//  PreloadDataView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct PreloadDataView: View {
    @State private var witnesses: [Witness] = []
    var body: some View {
        VStack {
            Text("You can fill your data here....")
            Text("Witnesses")
            
            HStack(alignment: .top) {
                VStack {
                    ForEach(witnesses, id: \.self) { witness in
                        WitnessView(witness: witnessBinding(for: witness))
                            .padding(.bottom)
                    }
                }
                VStack {
                    Button {
                        
                        witnesses.append(Witness(name: "", address: "", phoneNumber: ""))
                    } label: {
                        Label("Add Witness", systemImage: "plus.circle")
                    }
                    .disabled(witnesses.count >= 3)
                    Button {
                        witnesses.removeLast()
                    } label: {
                        Label("Remove Witness", systemImage: "minus.circle")
                    }
                    .disabled(witnesses.isEmpty)
                }
            }
        }
    }
    
    
    func witnessBinding(for witness: Witness) -> Binding<Witness> {
        return Binding(get: { witness }, set: { newValue in
            if let index = witnesses.firstIndex(of: witness) {
                witnesses[index] = newValue
            } else {
                // Handle missing witness case (e.g., print error or ignore)
            }
        })
    }
}


#Preview {
    PreloadDataView()
}
