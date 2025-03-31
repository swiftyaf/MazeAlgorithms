//
//  GrowingTreeMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 31/03/2025.
//

class GrowingTreeMazeGenerator: MazeGenerating {
    var costs: [Position: Int] = [:]

    func generateMaze(in grid: Grid) {
        for row in 0..<grid.rows {
            for col in 0..<grid.cols {
                let position = Position(row, col)
                if let cell = grid[position] {
                    costs[position] = Int.random(in: 1...100)
                }
            }
        }

        let startCell = grid.randomCell()
        var activeCells = [startCell]
        
        while !activeCells.isEmpty {
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
        }
    }
    
    func selectCell(from cells: [Cell]) -> Cell {
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
