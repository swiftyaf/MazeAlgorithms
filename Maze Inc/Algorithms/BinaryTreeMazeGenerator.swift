//
//  BinaryTreeMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

class BinaryTreeMazeGenerator: MazeGenerating {
    func generateMaze(in grid: Grid) {
        for row in 0..<grid.rows {
            for col in 0..<grid.cols {
                if let cell = grid.cell(at: Position(row, col)) {
                    let northCell = grid.cell(nextTo: cell, direction: .north)
                    let eastCell = grid.cell(nextTo: cell, direction: .east)
                    let nextCell = [northCell, eastCell].compactMap { $0 }.randomElement()
                    if let nextCell {
                        grid.link(cell1: cell, cell2: nextCell)
                    }
                }
            }
        }
    }
}
