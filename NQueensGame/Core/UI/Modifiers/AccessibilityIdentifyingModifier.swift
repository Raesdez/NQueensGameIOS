//
//  AccessibilityIdentifyingModifier.swift
//  NQueensGame
//
//  Created by Ramón on 30/9/25.
//

import SwiftUI

/// A SwiftUI modifier that applies the app's custom spacing as padding
struct AccessibilityIdentifyingModifier: ViewModifier {
    private let identifier: AccessibilityIdentifying

    init(identifier: AccessibilityIdentifying) {
        self.identifier = identifier
    }

    func body(content: Content) -> some View {
        content.accessibilityIdentifier(identifier.name)
    }
}

extension View {
    func accessibilityIdentifier(_ identifier: AccessibilityIdentifying) -> some View {
        modifier(AccessibilityIdentifyingModifier(identifier: identifier))
    }
}
