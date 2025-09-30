//
//  GameBoardView.swift
//  NQueensGame
//
//  Created by Ramón on 28/9/25.
//

import SwiftUI

struct GameBoardView: View {
    @Environment(GameViewModel.self) var viewModel
    
    var body: some View {
        makeBoard()
            .cornerRadius(20)
    }
}

extension GameBoardView {
    enum Identifiers: AccessibilityIdentifying {
        case piece
        case boardCell
    }
}

private extension GameBoardView {
    struct Constants {
        static var pieceScaleFactor: Double { 0.45 }
    }
    
    @ViewBuilder
    func makeBoard() -> some View {
        let maxBoardWidth = min(screenBounds.width, screenBounds.height) - Spacing.md.rawValue
        let cellSize = maxBoardWidth / CGFloat(viewModel.boardSize)
        let boardSize = cellSize * CGFloat(viewModel.boardSize)
        let columns = Array(repeating: GridItem(.fixed(cellSize), spacing: 0), count: viewModel.boardSize)
        
        ZStack {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(0..<(viewModel.boardSize * viewModel.boardSize), id: \.self) { index in
                    let row = index / viewModel.boardSize
                    let col = index % viewModel.boardSize
                    boardCell(coord: Coord(row: row, col: col), cellSize: cellSize)
                        .accessibilityIdentifier(Identifiers.boardCell)
                }
            }
            .frame(width: boardSize, height: boardSize)
            
            conflictHighlight(cellSize: cellSize)
        }
    }
    
    func conflictHighlight(cellSize: CGFloat) -> some View {
        let boardSize = cellSize * CGFloat(viewModel.boardSize)
        
        return ZStack {
            ForEach(Array(viewModel.conflicts), id: \.self) { conflict in
                Path { path in
                    let startPoint = getPoint(for: conflict.a, cellSize)
                    path.move(to: startPoint)
                    let endPoint = getPoint(for: conflict.b, cellSize)
                    path.addLine(to: endPoint)
                }
                .stroke(
                    .red.opacity(0.2),
                    style: StrokeStyle(
                        lineWidth: cellSize * 0.7,
                        lineCap: .round
                    )
                )
            }
        }
        .frame(width: boardSize, height: boardSize)
        .allowsHitTesting(false)
    }
    
    func getPoint(for coord: Coord, _ cellSize: CGFloat) -> CGPoint {
        CGPoint(
            x: CGFloat(coord.col) * cellSize + cellSize / 2,
            y: CGFloat(coord.row) * cellSize + cellSize / 2
        )
    }
    
    @ViewBuilder
    func boardCell(coord: Coord, cellSize: CGFloat) -> some View {
        ZStack {
            Rectangle()
                .fill((coord.row + coord.col).isMultiple(of: 2) ? Color.darkTile : Color.lightTile)
                .aspectRatio(1, contentMode: .fit)
            if viewModel.placedPieces.contains(coord) {
                Image(systemName: "crown.fill")
                    .resizable()
                    .foregroundColor(
                        viewModel.conflicts.contains(where: {
                            $0.a == coord || $0.b == coord
                        }) ? .red : .black
                    )
                    .frame(width: cellSize * Constants.pieceScaleFactor, height: cellSize * Constants.pieceScaleFactor)
                    .accessibilityIdentifier(Identifiers.piece)
            }
        }
        .onTapGesture {
            viewModel.tapCell(at: coord)
        }
    }
}
