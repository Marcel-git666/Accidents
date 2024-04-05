//
//  WitnessView.swift
//  Accidents
//
//  Created by Marcel Mravec on 05.04.2024.
//

import SwiftUI

struct WitnessView: View {
    @Binding var witness: Witness
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    TextField("Name", text: $witness.name)
                    TextField("Phone Number", text: $witness.phoneNumber)
                        .keyboardType(.phonePad)
                }
                TextField("Address", text: $witness.address)
            }
        }
        .padding(4)
        .border(LinearGradient(colors: [Color(UIColor.systemGray), .accentColor], startPoint: .topLeading, endPoint: .top), width: 3)
        
    }
}

#Preview {
    WitnessView(witness: Binding<Witness>(
        get: { Witness.sample },
        set: { newValue in
        }
    ))
    .padding()
}
