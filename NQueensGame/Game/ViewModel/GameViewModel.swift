//
//  GameViewModel.swift
//  NQueensGame
//
//  Created by Ramón on 27/9/25.
//

import Observation

@Observable
class GameViewModel {
    // MARK: - UI Properties
    
    /// If the game status is currently in error.
    private(set) var errorState: GameError?
    /// Display settings overlay to configure a new game
    private(set) var showGameSettingsView = true
    /// If it is the first game after init the close button is not available
    private(set) var isSettingsCloseButtonEnabled = false
    /// The range allowed to set the dynamic board size.
    let allowedBoardSizeRange = 4...20
    
    // MARK: Model related properties
    
    var boardSize: Int {
        gameModel.boardSize
    }
    var placedPieces: Set<Coord> {
        gameModel.placedPieces
    }
    var conflicts: Set<CoordPair> {
        gameModel.conflicts
    }
    var gameWon: Bool {
        gameModel.gameWon
    }
    var remainingPieces: Int {
        gameModel.remainingPieces
    }
    
    private var gameModel: any GameModel = NQueensGameModel()
    
    // MARK: - Functions
    
    func start(boardSize: Int) {
        isSettingsCloseButtonEnabled = true
        
        do {
            try gameModel.start(boardSize: boardSize)
        } catch GameError.minBoardSize {
            errorState = .minBoardSize
        } catch {
            print("Unknown error")
        }

        showGameSettingsView = false
    }
    
    func restart() {
        showGameSettingsView = true
    }
    
    func closeGameSettingsModal() {
        showGameSettingsView = false
    }
    
    func tapCell(at coord: Coord) {
        guard errorState == nil else {
            return
        }
        
        gameModel.selectCell(at: coord)
    }
}
