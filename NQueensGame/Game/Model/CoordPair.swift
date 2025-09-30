//
//  CoordPair.swift
//  NQueensGame
//
//  Created by Ramón on 27/9/25.
//

/// Stores a pair of coordinates.
///
/// - Note: The init orders the coordinates to make a pair and its simetrical the same, so that [(1,2), (3,4)] is the same as [(3,4), (1,2)]
struct CoordPair: Hashable {
    let a: Coord
    let b: Coord

    init(_ a: Coord, _ b: Coord) {
        if (a.row < b.row) || (a.row == b.row && a.col <= b.col) {
            self.a = a
            self.b = b
        } else {
            self.a = b
            self.b = a
        }
    }
}
