//
//  GameModel.swift
//  NQueensGame
//
//  Created by Ramón on 29/9/25.
//

import Observation

/// Game Model for the NQueens challenge. Main logic is to place the n amount of queens in a board of nxn without conflicts.
@Observable
class NQueensGameModel: GameModel {
    private(set) var boardSize: Int = 4
    private(set) var placedPieces = Set<Coord>()
    private(set) var conflicts = Set<CoordPair>()
    private(set) var gameWon: Bool = false
    
    var remainingPieces: Int {
        boardSize - placedPieces.count
    }
    
    func start(boardSize: Int) throws {
        self.boardSize = boardSize
        
        if boardSize < 4 {
            throw GameError.minBoardSize
        }
        
        placedPieces = Set<Coord>()
        conflicts = Set<CoordPair>()
        gameWon = false
    }
    
    func selectCell(at coord: Coord) {
        guard !gameWon else {
            return
        }
        
        if placedPieces.contains(coord) {
            removePiece(at: coord)
        } else {
            addPiece(at: coord)
        }
    }
}

private extension NQueensGameModel {
    func addPiece(at coord: Coord) {
        guard remainingPieces > 0,
              (0..<boardSize).contains(coord.row),
              (0..<boardSize).contains(coord.col)
        else {
            return
        }
        
        placedPieces.insert(coord)
        validate(new: coord)
        
        //Check if game won, no conflitcs and remainingQueens queens 0
        gameWon = conflicts.count == 0 && remainingPieces == 0
    }
    
    func removePiece(at coord: Coord) {
        placedPieces.remove(coord)
        
        // Remove any Conflicts where that queen was involved
        conflicts = conflicts.filter { $0.a != coord && $0.b != coord }
    }
    
    func validate(new coord: Coord) {
        let newConflicts = placedPieces.filter { q in
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
