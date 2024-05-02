//
//  AnyTransitions+Ext.swift
//  Accidents
//
//  Created by Marcel Mravec on 30.04.2024.
//

import SwiftUI

extension AnyTransition {
    static var slideFromLeft: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
            .combined(with: .scale(scale: 0.8))
        let removal = AnyTransition.move(edge: .trailing)
            .combined(with: .scale(scale: 0.8))
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var slideFromRight: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .scale(scale: 0.8))
        let removal = AnyTransition.move(edge: .leading)
            .combined(with: .scale(scale: 0.8))
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
