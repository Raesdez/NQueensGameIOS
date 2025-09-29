//
//  Gradient.swift
//  NQueensGame
//
//  Created by Ramón on 29/9/25.
//

import SwiftUI

struct Gradient {
    static var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color.backgroundGradientStart,
                Color.backgroundGradientEnd
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
