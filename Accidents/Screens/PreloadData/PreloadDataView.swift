//
//  PreloadDataView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct PreloadDataView: View {
    @StateObject private var vehicleManager = VehicleManager()
    
    var body: some View {
        VStack {
            Text("You can prefill your data here....")
            
        }
    }
}


#Preview {
    PreloadDataView()
}
