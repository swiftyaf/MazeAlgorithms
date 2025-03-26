//
//  HunterKillerMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 25/03/2025.
//

class HunterKillerMazeGenerator: MazeGenerating {
    func generateMaze(in grid: Grid) {
        var currentCell: Cell? = grid.randomCell()
        
        while let cell = currentCell {
            let unvisitedNeighbours = grid.neighbours(of: cell).filter { $0.links.isEmpty }
            
            if !unvisitedNeighbours.isEmpty {
                let neighbour = unvisitedNeighbours.randomElement()!
                grid.link(cell1: cell, cell2: neighbour)
                currentCell = neighbour
            } else {
                currentCell = nil
                for i in 0..<grid.rows * grid.cols {
                    let position = Position(i / grid.cols, i % grid.cols)
                    if let cell = grid[position] {
                        let visitedNeighbours = grid.neighbours(of: cell).filter { !$0.links.isEmpty }
                        if cell.links.isEmpty && !visitedNeighbours.isEmpty {
                            currentCell = cell
                            let neighbour = visitedNeighbours.randomElement()!
                            grid.link(cell1: cell, cell2: neighbour)
                            break
                        }
                    }
                }
            }
        }
    }
}
