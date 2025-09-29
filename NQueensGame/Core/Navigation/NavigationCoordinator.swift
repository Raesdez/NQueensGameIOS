//
//  NavigationCoordinator.swift
//  NQueensGame
//
//  Created by Ramón on 28/9/25.
//

import Observation
import SwiftUI

@Observable
/// - Note: Coordinator pattern based on: https://medium.com/@dikidwid0/mastering-navigation-in-swiftui-using-coordinator-pattern-833396c67db5
final class NavigationCoordinator {
    /// Handles the navigation stack.
    /// ``NavigationPath`` is a type eraser that allows us to navigate to different types of models (used since the first item in the list is the button to start a new match)
    var path = NavigationPath()

    // MARK: Flow control

    func popToRoot() {
        path = NavigationPath()
    }

    func push(_ option: NavigationOption) {
        path.append(option)
    }
}

extension NavigationCoordinator {
    @ViewBuilder
    func makeView(for option: NavigationOption) -> some View {
        switch option {
        case .home:
            HomeView()
        case .game:
            GameView()
        }
    }
}
