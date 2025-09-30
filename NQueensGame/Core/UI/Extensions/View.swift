//
//  View.swift
//  NQueensGame
//
//  Created by Ramón on 30/9/25.
//

import SwiftUI

extension View {
    /// Gets the bounds of the first connected scene window
    var screenBounds: CGRect {
        // Get the first connected scene
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return windowScene.screen.bounds
    }
}
