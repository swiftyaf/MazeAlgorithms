//
//  AldousBroderMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 25/03/2025.
//

public class AldousBroderMazeGenerator: MazeGenerating {
    var grid: Grid
    var generating = false
    var remainingCells = [Cell]()
    var unvisited = 0
    var cell: Cell

    public init(grid: Grid = Grid(rows: 10, cols: 10)) {
        self.grid = grid
        cell = grid.randomCell()
    }
    
    public func setGrid(_ grid: Grid) {
        self.grid = grid
        generating = false
    }
    
    public func generateNextStep() -> Bool {
        if !generating {
            generating = true
            cell = grid.randomCell()
            unvisited = grid.totalCells - 1
        }
        
        if unvisited == 0 {
            generating = false
            return false
        }
        
        let neighbour = grid.neighbours(of: cell).randomElement()!
        if neighbour.links.isEmpty {
            grid.link(cell1: cell, cell2: neighbour)
            unvisited -= 1
        }
        cell = neighbour
        return true
    }
        
    public func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateNextStep() {}
    }
}
