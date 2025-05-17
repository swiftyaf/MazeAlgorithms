//
//  PrimMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 31/03/2025.
//

public class PrimMazeGenerator: MazeGenerating {
    var costs: [Position: Int] = [:]
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

    public func generateStep() -> (generated: [Cell], evaluating: [Cell])? {
        if !generating {
            generating = true
            randomizeCosts()
            activeCells = [grid.randomCell()]
        }
        
        guard !activeCells.isEmpty else {
            generating = false
            return nil
        }
        
        let currentCell = activeCells.min { costs[$0.position]! < costs[$1.position]! }!
        let availableNeighbours = grid.neighbours(of: currentCell)
            .filter { $0.links.isEmpty }
        
        if !availableNeighbours.isEmpty {
            let neighbour = availableNeighbours.min { costs[$0.position]! < costs[$1.position]! }!
            grid.link(cell1: currentCell, cell2: neighbour)
            activeCells.append(neighbour)
        } else {
            activeCells.removeAll { $0.position == currentCell.position }
        }
        
        return (generated: [currentCell], evaluating: activeCells)
    }
    
    public func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateStep() != nil {}
    }
    
    private func randomizeCosts() {
        grid.allCells.map { $0.position }.forEach { position in
            costs[position] = Int.random(in: 1...100)
        }
    }
}
