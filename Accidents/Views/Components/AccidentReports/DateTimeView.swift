//
//  DateTimeView.swift
//  Accidents
//
//  Created by Marcel Mravec on 27.11.2024.
//

import SwiftUI

struct DateTimeView: View {
    let date: String
    let time: String

    var body: some View {
        
            Text(date)
                .font(.system(size: 10))
                .frame(width: 60, height: 20, alignment: .leading)
                .position(x: 80, y: 113)
            Text(time)
                .font(.system(size: 10))
                .frame(width: 60, height: 20, alignment: .leading)
                .position(x: 170, y: 113)
        
    }
}
