//
//  RecursiveBacktrackerMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 26/03/2025.
//

class RecursiveBacktrackerMazeGenerator: MazeGenerator {
    func generateMaze(in grid: Grid) {
        let randomPosition = Position(
            Int.random(in: 0..<grid.rows),
            Int.random(in: 0..<grid.cols)
        )
        var currentCell = grid[randomPosition]!
        var stack = [currentCell]
        
        while !stack.isEmpty {
            let current = stack.last!
            let unvisitedNeighbours = grid.neighbours(of: current).filter { $0.links.isEmpty }
            if unvisitedNeighbours.isEmpty {
                _ = stack.popLast()
            } else {
                let neighbour = unvisitedNeighbours.randomElement()!
                grid.link(cell1: current, cell2: neighbour)
                stack.append(neighbour)
            }
        }
    }
}
