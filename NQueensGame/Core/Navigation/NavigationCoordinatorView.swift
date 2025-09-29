//
//  NavigationCoordinatorView.swift
//  NQueensGame
//
//  Created by Ramón on 28/9/25.
//

import SwiftUI
import Observation

/// Entry point of the app that handles all the navigations options
/// - Note: It can be expanded later to include other types of presentations
struct NavigationCoordinatorView: View {
    @State var appCoordinator = NavigationCoordinator()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.makeView(for: .home)
                .navigationDestination(for: NavigationOption.self) { screen in
                    appCoordinator.makeView(for: screen)
                }
        }
        .environment(appCoordinator)
    }
}
