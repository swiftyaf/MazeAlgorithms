//
//  SimplifiedPrimMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 31/03/2025.
//

public class SimplifiedPrimMazeGenerator: MazeGenerating {
    var grid: Grid
    var generating = false
    var activeCells = [Cell]()

    public init(grid: Grid = Grid(rows: 10, cols: 10)) {
        self.grid = grid
    }
    
    public func setGrid(_ grid: Grid) {
        self.grid = grid
        generating = false
    }

    public func generateNextStep() -> Bool {
        if !generating {
            generating = true
            activeCells.append(grid.randomCell())
        }
        
        guard !activeCells.isEmpty else {
            generating = false
            return false
        }
        let currentCell = activeCells.randomElement()!
        let availableNeighbours = grid.neighbours(of: currentCell)
            .filter { $0.links.isEmpty }
        
        if !availableNeighbours.isEmpty {
            let neighbour = availableNeighbours.randomElement()!
            grid.link(cell1: currentCell, cell2: neighbour)
            activeCells.append(neighbour)
        } else {
            activeCells.removeAll { $0.position == currentCell.position }
        }
        
        return true
    }
    
    public func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateNextStep() {}

        let startCell = grid.randomCell()
        var activeCells = [startCell]
        
        while !activeCells.isEmpty {
            let currentCell = activeCells.randomElement()!
            let availableNeighbours = grid.neighbours(of: currentCell)
                .filter { $0.links.isEmpty }
            
            if !availableNeighbours.isEmpty {
                let neighbour = availableNeighbours.randomElement()!
                grid.link(cell1: currentCell, cell2: neighbour)
                activeCells.append(neighbour)
            } else {
                activeCells.removeAll { $0.position == currentCell.position }
            }
        }
    }
}
