//
//  MazeSolver.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 24/03/2025.
//

import Foundation

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
                fatalError()
            }
            
            // Look for the linked cell with the lowest weight (closest to start)
            guard let previousCell = cell.links.min(by: { weights[$0.position, default: Int.max] < weights[$1.position, default: Int.max] }) else {
                fatalError("No path found from end to start")
            }
            
            // If we're not making progress, there's a problem with the path
            if weights[previousCell.position, default: Int.max] >= weights[current, default: Int.max] {
                fatalError("No valid path - weights not decreasing toward start")
            }
            
            breadcrumbs.append(previousCell.position)
            current = previousCell.position
        }
        return breadcrumbs
    }
    
    public func longestPath(maze: Grid) -> [Position] {
        let weights = calculateWeights(maze: maze, start: maze.randomCell().position)
        let newStart = weights.keys.max(by: { weights[$0]! < weights[$1]! })!
        let newWeights = calculateWeights(maze: maze, start: newStart)
        let newFinish = newWeights.keys.max(by: { newWeights[$0]! < newWeights[$1]! })!
        return solveMaze(maze, start: newStart, end: newFinish)
    }
}
