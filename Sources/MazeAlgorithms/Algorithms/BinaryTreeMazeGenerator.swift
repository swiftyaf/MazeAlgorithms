//
//  BinaryTreeMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

public class BinaryTreeMazeGenerator: MazeGenerating {
    var grid: Grid
    var generating = false
    var remainingCells = [Cell]()
    
    public init(grid: Grid = Grid(rows: 10, cols: 10)) {
        self.grid = grid
    }
    
    public func generateNextStep() -> Bool {
        if !generating {
            generating = true
            remainingCells = grid.allCells
        }
        
        guard !remainingCells.isEmpty else {
            return false
        }

        let cell = remainingCells.removeFirst()
        let northCell = grid.cell(nextTo: cell, direction: .north)
        let eastCell = grid.cell(nextTo: cell, direction: .east)
        let nextCell = [northCell, eastCell].compactMap { $0 }.randomElement()
        if let nextCell {
            grid.link(cell1: cell, cell2: nextCell)
        }
        return true
    }

    func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateNextStep() {}
    }
}
