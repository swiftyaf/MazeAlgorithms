//
//  GrowingTreeMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 31/03/2025.
//

class GrowingTreeMazeGenerator: MazeGenerating {
    func generateMaze(in grid: Grid) {
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
        if Int.random(in: 0..<100) < 50 {
            cells.randomElement()!
        } else {
            cells.last!
        }
    }
}
