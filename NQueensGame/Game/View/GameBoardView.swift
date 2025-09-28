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
    }
}

private extension GameBoardView {
    @ViewBuilder
    func makeBoard() -> some View {
        let maxBoardWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - 20
        let cellSize = maxBoardWidth / CGFloat(viewModel.boardSize)
        let boardSize = cellSize * CGFloat(viewModel.boardSize)
        let columns = Array(repeating: GridItem(.fixed(cellSize), spacing: 0), count: viewModel.boardSize)
        
        ZStack {
            conflictHighlight(cellSize: cellSize)
            
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(0..<(viewModel.boardSize * viewModel.boardSize), id: \.self) { index in
                    let row = index / viewModel.boardSize
                    let col = index % viewModel.boardSize
                    boardCell(coord: Coord(row: row, col: col), cellSize: cellSize)
                }
            }
            .frame(width: boardSize, height: boardSize)
        }
    }
    
    func conflictHighlight(cellSize: CGFloat) -> some View {
        let boardSize = cellSize * CGFloat(viewModel.boardSize)
        
        return ZStack {
            ForEach(Array(viewModel.conflicts), id: \.self) { conflict in
                Path { path in
                    let startPoint = CGPoint(
                        x: CGFloat(conflict.a.col) * cellSize + cellSize / 2,
                        y: CGFloat(conflict.a.row) * cellSize + cellSize / 2
                    )
                    let endPoint = CGPoint(
                        x: CGFloat(conflict.b.col) * cellSize + cellSize / 2,
                        y: CGFloat(conflict.b.row) * cellSize + cellSize / 2
                    )
                    path.move(to: startPoint)
                    path.addLine(to: endPoint)
                }
                .stroke(.red.opacity(0.2),
                        style: StrokeStyle(
                            lineWidth: cellSize * 0.7,
                            lineCap: .round)
                )
            }
        }
        .frame(width: boardSize, height: boardSize)
    }
    
    @ViewBuilder
    func boardCell(coord: Coord, cellSize: CGFloat) -> some View {
        ZStack {
            Rectangle()
                .fill((coord.row + coord.col).isMultiple(of: 2) ? Color.secondary.opacity(0.25) : Color.secondary.opacity(0.6))
                .aspectRatio(1, contentMode: .fit)
            if viewModel.placedQueens.contains(coord) {
                Image(systemName: "crown.fill")
                    .resizable()
                    .foregroundColor(
                        viewModel.conflicts.contains(where: {
                            $0.a == coord || $0.b == coord
                        }) ? .red : .black
                    )
                    .frame(width: cellSize * 0.45, height: cellSize * 0.45)
            }
        }
        .onTapGesture {
            viewModel.tapCell(at: coord)
        }
    }
}
