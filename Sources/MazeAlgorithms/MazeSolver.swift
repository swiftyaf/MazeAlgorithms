//
//  MazeSolver.swift
//  MazeAlgorithms
//
//  Created by [Your Name] on [Date]
//

import Foundation // Keep Foundation for now, might need it or other core libraries.
// We assume Grid, Position, Cell are available from other files in the same module.

public class MazeSolver { // Dijkstra
    public func calculateWeights(maze: Grid, start: Position) -> [Position: Int] {
        var weights: [Position: Int] = [:]
        var pending: [Cell] = []
        guard let cell = maze[start] else {
            return weights
        }
        pending = [cell]
        weights[cell.position] = maze.cellWeights[cell.position]
        
        while !pending.isEmpty {
            pending.sort { weights[$0.position]! < weights[$1.position]! }
            let currentCell = pending.removeFirst()
            currentCell.links.forEach { neighbour in
                let totalWeight = weights[currentCell.position]! + maze.cellWeights[neighbour.position]!
                if weights[neighbour.position] == nil || weights[neighbour.position]! > totalWeight {
                    weights[neighbour.position] = totalWeight
                    pending.append(neighbour)
                }
            }
        }
        return weights
    }
    
    public func solveMaze(_ maze: Grid, start: Position, end: Position) -> [Position] {
        let weights = calculateWeights(maze: maze, start: start)
        var current = end
        var breadcrumbs = [end]
        while current != start {
            guard let cell = maze[current] else {
                // Consider more robust error handling or precondition checks
                fatalError("Cell not found in maze at position: \(current)")
            }
            // Find the neighbor with the smallest weight that is less than the current cell's weight
            let sortedNeighbors = cell.links.filter { weights[$0.position] != nil }.sorted { weights[$0.position]! < weights[$1.position]! }
            
            guard let previousCell = sortedNeighbors.first(where: { weights[$0.position]! < weights[current]! }) else {
                 // This can happen if start is unreachable from end or if weights are not set up as expected
                fatalError("Could not find a path back to start. Current cell: \(current), its links: \(cell.links.map {$0.position}), weights: \(weights)")
            }
            breadcrumbs.append(previousCell.position)
            current = previousCell.position
        }
        return breadcrumbs
    }
    
    public func longestPath(maze: Grid) -> [Position] {
        // Ensure maze has cells before proceeding
        guard let firstCell = maze.randomCell() else {
            // Or handle as an error, returning empty or throwing
            return [] 
        }
        let weights = calculateWeights(maze: maze, start: firstCell.position)
        guard let newStart = weights.keys.max(by: { weights[$0]! < weights[$1]! }) else {
            // This implies weights dictionary is empty, which shouldn't happen if randomCell() returned a cell
            return []
        }
        let newWeights = calculateWeights(maze: maze, start: newStart)
        guard let newFinish = newWeights.keys.max(by: { newWeights[$0]! < newWeights[$1]! }) else {
            // Similar to newStart, this implies newWeights is empty
            return []
        }
        return solveMaze(maze, start: newStart, end: newFinish)
    }
}
