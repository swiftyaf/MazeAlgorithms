//
//  MazeManager.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 24/03/2025.
//

import SwiftUI

@Observable
class MazeManager {
    var maze = Grid(rows: 12, cols: 12)
    let mazeGenerator = MazeGenerator()
    let mazeSolver = MazeSolver()
    var distances = [Position: Int]()
    var path = [Position(0, 0)]

    func updateGrid(rows: Int, cols: Int) {
        clearMaze()
        distances = [:]
        maze = Grid(rows: rows, cols: cols)
    }
    
    func generateMaze(rows: Int, cols: Int, algorithm: MazeAlgorithm) {
        clearMaze()
        maze = mazeGenerator.generateMaze(rows: rows, cols: cols, algorithm: algorithm)
        let deadends = maze.deadends()
        print("deadends: \(deadends.count)")
        let longestPath = mazeSolver.longestPath(maze: maze)
        print("longest path length: \(longestPath.count)")
    }
    
    func solveMaze() {
        let start = path.first!
        let end = path.last! != path.first! ? path.last! : Position(maze.rows - 1, maze.cols - 1)
        path = mazeSolver.solveMaze(
            maze,
            start: start,
            end: end
        ).reversed()
    }

    func longestPath() {
        path = mazeSolver.longestPath(maze: maze)
    }
    
    func calculateDistances() {
        distances = mazeSolver.calculateDistances(
            maze: maze,
            start: path.first!
        )
    }
    
    func clearMaze() {
        path = [Position(0, 0)]
    }
}
