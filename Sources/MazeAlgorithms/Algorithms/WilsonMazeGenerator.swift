//
//  WilsonMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 25/03/2025.
//

public class WilsonMazeGenerator: MazeGenerating {
    var grid: Grid
    var generating = false
    var unvisitedCells = [Position]()
    
    public init(grid: Grid = Grid(rows: 10, cols: 10)) {
        self.grid = grid
    }
    
    public func generateNextStep() -> Bool {
        if !generating {
            generating = true
            unvisitedCells = grid.allCells.map { $0.position }
            let first = unvisitedCells.indices.randomElement()!
            unvisitedCells.remove(at: first)
        }
        
        guard !unvisitedCells.isEmpty else {
            return false
        }
        
        var cellPosition = unvisitedCells.randomElement()!
        var path = [cellPosition]
        while unvisitedCells.contains(cellPosition) {
            let cell = grid[cellPosition]!
            cellPosition = grid.neighbours(of: cell).randomElement()!.position
            if let index = path.firstIndex(of: cellPosition) {
                path.removeSubrange(index+1..<path.count)
            } else {
                path.append(cellPosition)
            }
        }
        
        for i in 0..<(path.count-1) {
            let cell1 = grid[path[i]]!
            let cell2 = grid[path[i+1]]!
            grid.link(cell1: cell1, cell2: cell2)
            unvisitedCells.remove(at: unvisitedCells.firstIndex(of: path[i])!)
        }
        
        return true
    }

    func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateNextStep() {}
    }
}
