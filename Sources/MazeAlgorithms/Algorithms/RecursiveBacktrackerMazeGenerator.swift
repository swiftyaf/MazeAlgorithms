//
//  RecursiveBacktrackerMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 26/03/2025.
//

public class RecursiveBacktrackerMazeGenerator: MazeGenerating {
    var grid: Grid
    var generating = false
    private var stack: [Cell] = []
    
    public init(grid: Grid = Grid(rows: 10, cols: 10)) {
        self.grid = grid
    }
    
    public func setGrid(_ grid: Grid) {
        self.grid = grid
    }
    
    public func generateNextStep() -> Bool {
        if !generating {
            generating = true
            stack = [grid.randomCell()]
        }

        if stack.isEmpty {
            return false
        }
        
        let current = stack.last!
        let unvisitedNeighbours = grid.neighbours(of: current).filter { $0.links.isEmpty }
        if unvisitedNeighbours.isEmpty {
            _ = stack.popLast()
        } else {
            let neighbour = unvisitedNeighbours.randomElement()!
            grid.link(cell1: current, cell2: neighbour)
            stack.append(neighbour)
        }
        return true
    }
    
    func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateNextStep() {}
    }
}
