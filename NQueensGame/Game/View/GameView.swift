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
            if viewModel.errorState == nil {
                VStack {
                    makeTopButtonsView()
                    GameBoardView()
                        .environment(viewModel)
                    makeRemainingQueensView()
                    Spacer()
                }
                .overlay {
                    if viewModel.gameWon {
                        Text("Yay you won")
                    }
                }
            } else {
                Text("Invalid board size")
                    .foregroundStyle(.secondary)
            }
            makeGameSettingsOverlayView()
        }
        .animation(.easeInOut, value: viewModel.showShowGameSettingsView)
    }
}

private extension GameView {
    @ViewBuilder
    func makeGameSettingsOverlayView() -> some View {
        if viewModel.showShowGameSettingsView {
            Color.gray
                .opacity(0.9)
                .ignoresSafeArea()
                .blur(radius: 3)
            BoardSizePickerView(
                selectedNumber: viewModel.boardSize,
                startGameButtonTappedAction: { size in
                    viewModel.start(boardSize: size)
                }, closeButtonTappedAction: {
                    viewModel.closeGameSettingsModal()
                })
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 11)
            .padding(.horizontal, 25)
        }
    }
    
    func makeTopButtonsView() -> some View {
        HStack {
            Button {
               print("Go back")
            } label: {
                Image(systemName: "arrow.backward.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            Spacer()
            Button {
                viewModel.restart()
            } label: {
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 40)
    }
    
    func makeRemainingQueensView() -> some View {
        Text("Remaining Queens: \(viewModel.remainingQueens)")
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
            )
            .foregroundColor(.white)
    }
}

#Preview {
    GameView()
}
