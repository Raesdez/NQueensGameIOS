//
//  Font.swift
//  NQueensGame
//
//  Created by Ramón on 29/9/25.
//

import SwiftUI

/// A SwiftUI modifier that applies the app's custom font at a given size.
struct FontModifier: ViewModifier {
    private let size: FontSize
    private let font: FontType

    init(size: FontSize, font: FontType) {
        self.size = size
        self.font = font
    }

    func body(content: Content) -> some View {
        content.font(.custom(font.rawValue, size: size.rawValue))
    }
}

extension View {
    func textFont(_ size: FontSize = .regular, _ font: FontType = .regular) -> some View {
        modifier(FontModifier(size: size, font: font))
    }
}
