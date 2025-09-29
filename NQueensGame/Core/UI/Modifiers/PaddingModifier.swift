//
//  PaddingModifier.swift
//  NQueensGame
//
//  Created by Ramón on 29/9/25.
//


import SwiftUI

/// A SwiftUI modifier that applies the app's custom spacing as padding
struct PaddingModifier: ViewModifier {
    private let insets: Edge.Set
    private let spacing: Spacing

    init(insets: Edge.Set, spacing: Spacing) {
        self.insets = insets
        self.spacing = spacing
    }

    func body(content: Content) -> some View {
        content.padding(insets, spacing.rawValue)
    }
}

extension View {
    func padding(_ insets: Edge.Set, _ spacing: Spacing) -> some View {
        modifier(PaddingModifier(insets: insets, spacing: spacing))
    }
}
