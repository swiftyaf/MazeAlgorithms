//
//  SimplifiedPrimMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 31/03/2025.
//

class SimplifiedPrimMazeGenerator: MazeGenerating {
    func generateMaze(in grid: Grid) {
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
