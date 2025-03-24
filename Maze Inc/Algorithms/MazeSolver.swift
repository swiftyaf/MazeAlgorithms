//
//  MazeSolver.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 24/03/2025.
//

class MazeSolver { // Dijkstra
    func solveMaze(_ maze: Grid, start: Position) {
        var distances : [Position: Int] = [:]
        var frontier: [Cell] = []
        guard let cell = maze.cell(at: start.row, start.col) else {
            return
        }
        frontier = [cell]
        distances[Position(row: cell.row, col: cell.col)] = 0
        cell.value = "0"
        
        while !frontier.isEmpty {
            var newFrontier: [Cell] = []
            for cell in frontier {
                for neighbor in cell.links {
                    if !distances.keys.contains(Position(row: neighbor.row, col: neighbor.col)) {
                        let dist = distances[Position(row: cell.row, col: cell.col)]! + 1
                        distances[Position(row: neighbor.row, col: neighbor.col)] = dist
                        neighbor.value = "\(dist)"
                        newFrontier.append(neighbor)
                    }
                }
            }
            frontier = newFrontier
        }
        maze.draw()
    }
}

struct Position: Hashable {
    let row: Int
    let col: Int
}
