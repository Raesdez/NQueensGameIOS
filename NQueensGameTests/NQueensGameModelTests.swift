//
//  NQueensGameModelTests.swift
//  NQueensGame
//
//  Created by Ramón on 30/9/25.
//

import Testing
@testable import NQueensGame

@MainActor
struct NQueensGameModelTests {
    private var gameModel = NQueensGameModel()
    
    @Test(
        "Throw error when the game is atempted to start with an invalid board size",
        arguments: [-5, 1, 2, 3, 0]
    )
    func errorWhenBoardSizeInvalid(size: Int) throws {
        #expect(throws: GameError.self) {
            try gameModel.start(boardSize: size)
        }
    }
    
    @Test("Mark conflicts between two Queens attacking each other")
    func conflictWithTwoPieces() throws {
        try gameModel.start(boardSize: 4)
        
        let piecesToAdd = [
            // Piece a
            Coord(row: 2, col: 2),
            // Piece b: 1 vertical conflict
            Coord(row: 0, col: 2),
            // Piece c: 2 conflicts (with a and b)
            Coord(row: 1, col: 1),
            // Piece d: No conflict
            Coord(row: 3, col: 0)
        ]
        
        for piece in piecesToAdd {
            gameModel.selectCell(at: piece)
        }
        
        let expectedConflicts: Set<CoordPair> = [
            CoordPair(piecesToAdd[0], piecesToAdd[1]),
            CoordPair(piecesToAdd[0], piecesToAdd[2]),
            CoordPair(piecesToAdd[1], piecesToAdd[2])
        ]
        
        #expect(expectedConflicts == gameModel.conflicts)
    }
    
    @Test("Remove piece and clear conflict")
    func removePieceClearConflict() throws {
        try gameModel.start(boardSize: 4)

        gameModel.selectCell(at: Coord(row: 0, col: 1))
        gameModel.selectCell(at: Coord(row: 3, col: 1))
        gameModel.selectCell(at: Coord(row: 2, col: 3))
        
        #expect(gameModel.conflicts.count == 2)
        
        gameModel.selectCell(at: Coord(row: 2, col: 3))
        
        #expect(gameModel.conflicts.count == 1)
    }
    
    @Test("Win game")
    func gameWon() throws {
        try gameModel.start(boardSize: 4)
        #expect(!gameModel.gameWon)
        
        let piecesToAdd = [
            Coord(row: 1, col: 0),
            Coord(row: 3, col: 1),
            Coord(row: 0, col: 2),
            Coord(row: 2, col: 3)
        ]
        
        for piece in piecesToAdd {
            gameModel.selectCell(at: piece)
        }
                
        #expect(gameModel.gameWon)
        
        // Ignore tap cell on a won game
        #expect(gameModel.placedPieces.count == 4)
        
        gameModel.selectCell(at: Coord(row: 1, col: 0))
        
        #expect(gameModel.placedPieces.count == 4)
    }
}

