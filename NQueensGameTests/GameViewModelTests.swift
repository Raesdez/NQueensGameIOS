//
//  GameViewModelTests.swift
//  NQueensGame
//
//  Created by Ramón on 29/9/25.
//

import Testing
@testable import NQueensGame

struct GameViewModelTests {
    let viewModel = GameViewModel()
    
    @Test(
        "Publish display error if board size is invalid",
        arguments: [-1, 0, 1, 2, 3]
    )
    func displayErrorIfBoardSizeInvalid(_ boardSize: Int) throws {
        #expect(viewModel.errorState == nil)
        viewModel.start(boardSize: boardSize)
        #expect(viewModel.errorState == .minBoardSize)
    }
    
    @Test(
        "Ignore queen placement out of bounds",
        arguments: [Coord(row: -1, col: 5), Coord(row: 2, col: 7)]
    )
    func ignorePlacementsOutOfBounds(_ coord: Coord) throws {
        viewModel.start(boardSize: 4)
        viewModel.tapCell(at: coord)
        
        #expect(viewModel.placedPieces.count == 0)
    }
    
    @Test("Test reset active game")
    func resetActiveGame() {
        viewModel.start(boardSize: 4)
        viewModel.tapCell(at: Coord(row: 2, col: 2))
        
        #expect(viewModel.boardSize == 4)
        #expect(!viewModel.showGameSettingsView)
        #expect(viewModel.placedPieces.count == 1)
        
        viewModel.restart()
        #expect(viewModel.showGameSettingsView)
        
        viewModel.start(boardSize: 10)
        #expect(viewModel.boardSize == 10)
        #expect(!viewModel.showGameSettingsView)
        #expect(viewModel.placedPieces.isEmpty)
        
    }
    
    @Test("Test publish display of settings modal and dismiss")
    func displayAndDismissSettingsModal() {
        viewModel.start(boardSize: 4)
        #expect(!viewModel.showGameSettingsView)
        
        viewModel.restart()
        #expect(viewModel.showGameSettingsView)
        
        viewModel.closeGameSettingsModal()
        #expect(!viewModel.showGameSettingsView)
    }
    
    @Test("Settings overlay should not display close button on first game setting")
    func settingsOverlayCloseButton() {
        #expect(!viewModel.isSettingsCloseButtonEnabled)
        viewModel.start(boardSize: 4)
        #expect(viewModel.isSettingsCloseButtonEnabled)
    }
    
    @Test("Refuse to perform tap cell action if its in error state")
    func ignoreTapCellIfErrorState() {
        viewModel.start(boardSize: -5)
        #expect(viewModel.placedPieces.isEmpty)
        viewModel.tapCell(at: Coord(row: 0, col: 0))
        #expect(viewModel.placedPieces.isEmpty)
    }
}

