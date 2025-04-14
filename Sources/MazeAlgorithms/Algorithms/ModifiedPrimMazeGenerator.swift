//
//  ModifiedPrimMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 31/03/2025.
//

public class ModifiedPrimMazeGenerator: MazeGenerating {
    var grid: Grid
    var generating = false
    var inCells = [Cell]()
    var frontierCells = [Cell]()
    var outCells = [Cell]()
    
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
            inCells = [grid.randomCell()]
            frontierCells = grid.neighbours(of: inCells[0])
            outCells = grid.allCells
                .filter { !inCells.contains($0) }
                .filter { !frontierCells.contains($0) }
        }
        
        if frontierCells.isEmpty {
            generating = false
            return false
        }
        
        let cell = frontierCells.randomElement()!
        frontierCells.remove(at: frontierCells.firstIndex(of: cell)!)
        let randomInCell = inCells
            .filter { grid.neighbours(of: $0).contains(cell) }
            .randomElement()!
        grid.link(cell1: randomInCell, cell2: cell)
        inCells.append(cell)
        let outNeighbours = grid.neighbours(of: cell).filter { outCells.contains($0) }
        if !outNeighbours.isEmpty {
            frontierCells.append(contentsOf: outNeighbours)
            for outNeighbour in outNeighbours {
                outCells.removeAll { $0 == outNeighbour }
            }
        }
        return true
    }
    
    public func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateNextStep() {}
    }
}
