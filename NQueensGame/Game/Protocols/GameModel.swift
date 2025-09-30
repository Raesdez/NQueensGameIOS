//
//  GameModelProtocol.swift
//  NQueensGame
//
//  Created by Ramón on 29/9/25.
//

/// Protocol that set the common interface for a Game.
/// - Note: It allows to expand the game beyond Queen pieces.
protocol GameModel {
    var boardSize: Int { get }
    /// Current pieces placed in board by the user, identified by their cell (coordinated)
    var placedPieces: Set<Coord> { get }
    /// Reflects two pieces that are in conflict.
    var conflicts: Set<CoordPair> { get }
    /// If `true` then the game has finished since the user has won.
    var gameWon: Bool { get }
    /// Pieces left to place on board
    var remainingPieces: Int { get }
    
    /// Start a new game with the provided board size, refreshing properties
    func start(boardSize: Int) throws
    /// A cell is selected to perform an action (add piece or remove piece, based on status)
    func selectCell(at coord: Coord)
}
