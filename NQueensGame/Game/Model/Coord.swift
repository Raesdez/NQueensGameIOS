//
//  Coord.swift
//  NQueensGame
//
//  Created by Ramón on 27/9/25.
//
import UIKit

struct Coord: Hashable {
    let row: Int
    let col: Int
    
    var cgPoint: CGPoint {
        CGPoint(x: row, y: col)
    }
}
