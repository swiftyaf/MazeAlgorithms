//
//  WilsonMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 25/03/2025.
//

class WilsonMazeGenerator: MazeGenerating {
    func generateMaze(in grid: Grid) {
        var unvisitedCells = [Position]()
        for row in 0..<grid.rows {
            for col in 0..<grid.cols {
                if let cell = grid[Position(row, col)] {
                    unvisitedCells.append(cell.position)
                }
            }
        }
        let first = unvisitedCells.randomElement()!
        unvisitedCells.remove(at: unvisitedCells.firstIndex(of: first)!)
        while !unvisitedCells.isEmpty {
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
        }
    }
}
