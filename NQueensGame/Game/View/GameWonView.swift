//
//  GameWonView.swift
//  NQueensGame
//
//  Created by Ramón on 30/9/25.
//

import SwiftUI
import RiveRuntime

// - Note: animation provided in https://rive.app/marketplace/8331-15961-trophy-demonstration/ under CC-BY license.
struct GameWonView: View {
    @State private var riveViewModel = RiveViewModel(fileName: "trophy")
    var startNewGameAction: (() -> Void)?
    var goHomeAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: Spacing.lg.rawValue) {
            makeAnimationView()
            makeStartAgainButton()
            makeGoGomeButton()
                .padding(.bottom, .lg)
        }
        .padding()
        .background(Color.background)
        .cornerRadius(20)
        .shadow(radius: 11)
    }
}

extension GameWonView {
    enum Identifiers: AccessibilityIdentifying {
        case animation
        case startAgainButton
        case goHomeButton
    }
}

private extension GameWonView {
    func makeAnimationView() -> some View {
        riveViewModel
            .view()
            .frame(height: 400)
            .onAppear {
                riveViewModel.triggerInput("Click")
            }
    }
    
    func makeStartAgainButton() -> some View {
        Button(action: {
            startNewGameAction?()
        }, label: {
            Text("Start a new game")
                .foregroundColor(Color.textOnBackground)
                .textFont(.buttonStandard)
                .padding()
                .background(Color.appPrimary)
                .cornerRadius(30)
        })
        .accessibilityIdentifier(Identifiers.startAgainButton)
    }
    
    func makeGoGomeButton() -> some View {
        Button(action: {
            goHomeAction?()
        }, label: {
            Text("Go home")
                .foregroundColor(Color.textOnBackground)
                .textFont(.buttonStandard)
                .padding()
                .background(Color.gray)
                .cornerRadius(30)
        })
        .accessibilityIdentifier(Identifiers.goHomeButton)
    }
}

#Preview {
    GameWonView()
}
