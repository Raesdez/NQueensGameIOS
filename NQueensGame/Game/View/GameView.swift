//
//  GameView.swift
//  NQueensGame
//
//  Created by Ramón on 27/9/25.
//

import SwiftUI

struct GameView: View {
    @State private var viewModel: GameViewModel
    
    init() {
        viewModel = GameViewModel()
    }
    
    var body: some View {
        ZStack {
            Gradient.backgroundGradient
            makeContentView()
            makeGameSettingsOverlayView()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.restart()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                }
                .accessibilityIdentifier(Identifiers.restartButton)
            }
        
        }
    }
}

extension GameView {
    enum Identifiers: AccessibilityIdentifying {
        case restartButton
        case board
        case title
        case challengeGoalText
        case remainingPiecesTitle
        case remainingPiecesNumber
    }
}

private extension GameView {
    struct Constants {
        static var animationDuration: Double { 0.25 }
        static var overlayBackgroundOpacity: Double { 0.95 }
    }
    
    @ViewBuilder
    func makeContentView() -> some View {
        if viewModel.errorState == nil {
            VStack(spacing: Spacing.md.rawValue) {
                Text("Playing on a \(viewModel.boardSize)x\(viewModel.boardSize) board")
                    .textFont(.title)
                    .foregroundColor(Color.textOnBackground)
                    .accessibilityIdentifier(Identifiers.title)
                GameBoardView()
                    .environment(viewModel)
                    .accessibilityIdentifier(Identifiers.board)
                makeRemainingQueensView()
                Spacer()
            }
            .overlay {
                if viewModel.gameWon {
                    Text("Yay you won")
                        .foregroundColor(.white)
                }
            }
            .padding(.top, .md)
        } else {
            Text("Invalid board size")
                .foregroundStyle(.secondary)
        }
    }
    
    @ViewBuilder
    func makeGameSettingsOverlayView() -> some View {
        if viewModel.showGameSettingsView {
            ZStack {
                Color.gray
                    .opacity(Constants.overlayBackgroundOpacity)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                BoardSizePickerView(
                    allowedBoardRange: viewModel.allowedBoardSizeRange,
                    selectedNumber: viewModel.boardSize,
                    isCloseButtonAvailable: viewModel.isSettingsCloseButtonEnabled,
                    startGameButtonTappedAction: { size in
                        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                            viewModel.start(boardSize: size)
                        }
                    },
                    closeButtonTappedAction: {
                        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                            viewModel.closeGameSettingsModal()
                        }
                    }
                )
                .padding(.horizontal, .lg)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            .zIndex(1)
            .animation(.easeInOut(duration: Constants.animationDuration), value: viewModel.showGameSettingsView)
        }
    }
    
    func makeRemainingQueensView() -> some View {
        HStack {
            Text("Challenge. Place all required queens in the board so no piece threatens another")
                .textFont(.subtitle, .medium)
                .foregroundColor(Color.textStandard)
                .padding()
                .accessibilityIdentifier(Identifiers.challengeGoalText)
            VStack {
                Text("Pieces left")
                    .textFont(.regular)
                    .foregroundColor(Color.textStandard)
                    .accessibilityIdentifier(Identifiers.remainingPiecesTitle)
                Text("\(viewModel.remainingPieces)")
                    .textFont(.heading, .bold)
                    .accessibilityIdentifier(Identifiers.remainingPiecesNumber)
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
        .padding(.all,.sm)
    }
}

#Preview {
    NavigationStack {
        GameView()
    }
}
