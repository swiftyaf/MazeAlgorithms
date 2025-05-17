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
    
    public func setGrid(_ grid: Grid) {
        self.grid = grid
        generating = false
    }

    public func generateStep() -> (generated: [Cell], evaluating: [Cell])? {
        if !generating {
            generating = true
            remainingCells = grid.allCells
        }
        
        guard !remainingCells.isEmpty else {
            generating = false
            return nil
        }

        let cell = remainingCells.removeFirst()
        let northCell = grid.cell(nextTo: cell, direction: .north)
        let eastCell = grid.cell(nextTo: cell, direction: .east)
        let nextCell = [northCell, eastCell].compactMap { $0 }.randomElement()
        if let nextCell {
            grid.link(cell1: cell, cell2: nextCell)
        }
        return (generated: [cell], evaluating: [northCell, eastCell].compactMap { $0 })
    }

    public func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateStep() != nil {}
    }
}
