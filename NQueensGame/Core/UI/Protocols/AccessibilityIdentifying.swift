//
//  AccessibilityIdentifying.swift
//  NQueensGame
//
//  Created by Ramón on 30/9/25.
//

/// Allows to create entities (mainly enums) to declare accessibility identifiers and set them directly using the ``AccessibilityIdentifyingModifier``.
protocol AccessibilityIdentifying {
    var name: String { get }
}

extension AccessibilityIdentifying {
    var name: String {
        String(describing: self)
    }
}
