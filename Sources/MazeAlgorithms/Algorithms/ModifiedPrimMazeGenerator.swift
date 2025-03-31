//
//  ModifiedPrimMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 31/03/2025.
//

class ModifiedPrimMazeGenerator: MazeGenerating {
    func generateMaze(in grid: Grid) {
        let startCell = grid.randomCell()
        var inCells = [startCell]
        var frontierCells = grid.neighbours(of: startCell)
        var outCells = grid.cells.flatMap { $0 }
            .filter { !inCells.contains($0) }
            .filter { !frontierCells.contains($0) }

        while !frontierCells.isEmpty {
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
        }
    }
}
