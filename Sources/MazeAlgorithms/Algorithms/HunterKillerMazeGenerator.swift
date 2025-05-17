//
//  HunterKillerMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 25/03/2025.
//

public class HunterKillerMazeGenerator: MazeGenerating {
    var grid: Grid
    var generating = false
    var currentCell: Cell?
    
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
            currentCell = grid.randomCell()
        }
        
        guard let cell = currentCell else {
            generating = false
            return nil
        }
        
        let unvisitedNeighbours = grid.neighbours(of: cell).filter { $0.links.isEmpty }
        
        if !unvisitedNeighbours.isEmpty {
            let neighbour = unvisitedNeighbours.randomElement()!
            grid.link(cell1: cell, cell2: neighbour)
            currentCell = neighbour
        } else {
            currentCell = nil
            for i in 0..<grid.rows * grid.cols {
                let position = Position(i / grid.cols, i % grid.cols)
                if let newCell = grid[position] {
                    let visitedNeighbours = grid.neighbours(of: newCell).filter { !$0.links.isEmpty }
                    if newCell.links.isEmpty && !visitedNeighbours.isEmpty {
                        currentCell = newCell
                        let neighbour = visitedNeighbours.randomElement()!
                        grid.link(cell1: newCell, cell2: neighbour)
                        break
                    }
                }
            }
        }
        return (generated: [currentCell].compactMap { $0 }, evaluating: unvisitedNeighbours)
    }
    
    public func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateStep() != nil {}
    }
}
