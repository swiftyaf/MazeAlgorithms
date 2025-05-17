//
//  GrowingTreeMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 31/03/2025.
//

public class GrowingTreeMazeGenerator: MazeGenerating {
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
        
        let currentCell = selectCell(from: activeCells)
        let availableNeighbours = grid.neighbours(of: currentCell)
            .filter { $0.links.isEmpty }
        
        if !availableNeighbours.isEmpty {
            let neighbour = availableNeighbours.randomElement()!
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
    
    private func selectCell(from cells: [Cell]) -> Cell {
        let randInt = Int.random(in: 0..<100)
        if randInt < 33 {
            return cells.randomElement()!
        } else if randInt < 66 {
            return cells.last!
        } else {
            return cells.min { costs[$0.position]! < costs[$1.position]! }!
        }
    }
}
