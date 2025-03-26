//
//  MazeSolver.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 24/03/2025.
//

class MazeSolver { // Dijkstra
    func calculateDistances(maze: Grid, start: Position) -> [Position: Int] {
        var distances: [Position: Int] = [:]
        var frontier: [Cell] = []
        guard let cell = maze[start] else {
            return distances
        }
        frontier = [cell]
        distances[cell.position] = 0
        
        while !frontier.isEmpty {
            var newFrontier: [Cell] = []
            for cell in frontier {
                for neighbor in cell.links {
                    if !distances.keys.contains(neighbor.position) {
                        let dist = distances[cell.position]! + 1
                        distances[neighbor.position] = dist
                        newFrontier.append(neighbor)
                    }
                }
            }
            frontier = newFrontier
        }
        return distances
    }
    
    func solveMaze(_ maze: Grid, start: Position, end: Position) -> [Position] {
        let distances = calculateDistances(maze: maze, start: start)
        var current = end
        var breadcrumbs = [end]
        while current != start {
            guard let cell = maze[current] else {
                fatalError()
            }
            guard let previousCell = cell.links.first(where: { distances[$0.position]! < distances[current]! }) else {
                fatalError()
            }
            breadcrumbs.append(previousCell.position)
            current = previousCell.position
        }
        return breadcrumbs
    }
    
    func longestPath(maze: Grid) -> [Position] {
        let distances = calculateDistances(maze: maze, start: maze.randomCell().position)
        let newStart = distances.keys.max(by: { distances[$0]! < distances[$1]! })!
        let newDistances = calculateDistances(maze: maze, start: newStart)
        let newFinish = newDistances.keys.max(by: { newDistances[$0]! < newDistances[$1]! })!
        return solveMaze(maze, start: newStart, end: newFinish)
    }
}
