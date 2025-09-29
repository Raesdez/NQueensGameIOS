//
//  GameViewModel.swift
//  NQueensGame
//
//  Created by Ramón on 27/9/25.
//

import Observation

@Observable
class GameViewModel {
    // MARK: - Properties
    
    private(set) var boardSize: Int = 4
    /// List of queens currently placed on board
    private(set) var placedQueens = Set<Coord>()
    /// List of pairs of queens that are currently threatening each other
    private(set) var conflicts = Set<CoordPair>()
    /// If `true` then the game has finished since the user has won.
    private(set) var gameWon: Bool = false
    /// If the game status is currently in error.
    private(set) var errorState: GameError?
    /// Display settings overlay to configure a new game
    private(set) var showGameSettingsView = true
    /// If it is the first game after init the close button is not available
    private(set) var isSettingsCloseButtonEnabled = false
    
    var remainingQueens: Int {
        boardSize - placedQueens.count
    }
    
    // MARK: - Functions
    
    func start(boardSize: Int) {
        isSettingsCloseButtonEnabled = true
        self.boardSize = boardSize
        
        if boardSize < 4 {
            errorState = .minBoardSize
        }
        
        showGameSettingsView = false
        placedQueens = Set<Coord>()
        conflicts = Set<CoordPair>()
        gameWon = false
    }
    
    func restart() {
        showGameSettingsView = true
    }
    
    func closeGameSettingsModal() {
        showGameSettingsView = false
    }
    
    func tapCell(at coord: Coord) {
        guard errorState == nil,
              !gameWon else {
            return
        }
        
        if placedQueens.contains(coord) {
            removeQueen(at: coord)
        } else {
            addQueen(at: coord)
        }
    }
}

private extension GameViewModel {
    func addQueen(at coord: Coord) {
        guard remainingQueens > 0,
              (0..<boardSize).contains(coord.row),
              (0..<boardSize).contains(coord.col)
        else {
            return
        }
        
        placedQueens.insert(coord)
        validate(new: coord)
        
        //Check if game won, no conflitcs and remainingQueens queens 0
        gameWon = conflicts.count == 0 && remainingQueens == 0
    }
    
    func removeQueen(at coord: Coord) {
        placedQueens.remove(coord)
        
        // Remove any Conflicts where that queen was involved
        conflicts = conflicts.filter { $0.a != coord && $0.b != coord }
    }
    
    
    func validate(new coord: Coord) {
        let newConflicts = placedQueens.filter { q in
            guard q != coord else {
                // Ignore the same placement
                return false
            }
            
            // Rows and columns
            return q.col == coord.col ||
                q.row == coord.row ||
                // Diagonals
                coord.col + coord.row == q.col + q.row ||
                coord.row - coord.col == q.row - q.col
        }.map {
            CoordPair($0, coord)
        }
        
        conflicts.formUnion(newConflicts)
    }
}
