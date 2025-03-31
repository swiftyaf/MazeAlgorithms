//
//  PrimMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 31/03/2025.
//

class PrimMazeGenerator: MazeGenerating {
    func generateMaze(in grid: Grid) {
        let startCell = grid.randomCell()
        var activeCells = [startCell]
        
        var costs: [Position: Int] = [:]
        for row in 0..<grid.rows {
            for col in 0..<grid.cols {
                let position = Position(row, col)
                if let cell = grid[position] {
                    costs[position] = Int.random(in: 1...100)
                }
            }
        }
        
        while !activeCells.isEmpty {
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
        }
    }
}
