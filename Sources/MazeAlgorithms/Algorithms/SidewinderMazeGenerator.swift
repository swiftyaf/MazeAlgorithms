//
//  SidewinderMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

public class SidewinderMazeGenerator: MazeGenerating {
    var grid: Grid
    var generating = false
    var currentRow = 0
    var currentCol = 0
    var run = [Cell]()

    public init(grid: Grid = Grid(rows: 10, cols: 10)) {
        self.grid = grid
    }
    
    public func setGrid(_ grid: Grid) {
        self.grid = grid
        generating = false
    }

    public func generateStep() -> (generated: [Cell], evaluating: [Cell])? {
        var current: [Cell] = []
        var next: [Cell] = []
        
        if !generating {
            generating = true
            currentRow = 0
            currentCol = 0
        }
        
        if currentCol == 0 {
            run = []
        }
        if let cell = grid[currentRow, currentCol] {
            current = [cell]
            run.append(cell)
            let atEastEdgeOfGrid = currentCol == grid.cols - 1
            let atNorthEdgeOfGrid = currentRow == 0
            let shouldCloseOut = atEastEdgeOfGrid
            || (!atNorthEdgeOfGrid && Int.random(in: 0...1) == 0)
            
            if shouldCloseOut {
                let randomCell = run.randomElement()!
                if let northCell = grid.cell(nextTo: randomCell, direction: .north) {
                    grid.link(cell1: randomCell, cell2: northCell)
                    next.append(northCell)
                    next.append(contentsOf: run)
                }
                run = []
            } else {
                if let eastCell = grid.cell(nextTo: cell, direction: .east) {
                    grid.link(cell1: cell, cell2: eastCell)
                    next.append(eastCell)
                }
            }
        }
        currentCol += 1
        if currentCol == grid.cols {
            currentRow += 1
            currentCol = 0
            if currentRow == grid.rows {
                generating = false
                return nil
            }
        }
        next.append(contentsOf: run)
        return (generated: current, evaluating: next)
    }
    
    public func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateStep() != nil {}
    }
}
