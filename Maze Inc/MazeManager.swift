//
//  MazeManager.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 24/03/2025.
//

import SwiftUI

@Observable
class MazeManager {
    var maze = Grid(rows: 10, cols: 8)
    let mazeGenerator = MazeGenerator()
    let mazeSolver = MazeSolver()

    
    func updateGrid(rows: Int, cols: Int) {
        maze = Grid(rows: rows, cols: cols)
    }
    
    func generateMaze(rows: Int, cols: Int, algorithm: MazeAlgorithm) {
        maze = mazeGenerator.generateMaze(rows: rows, cols: cols, algorithm: algorithm)
        let deadends = maze.deadends()
        print("deadends: \(deadends.count)")
        let path = mazeSolver.longestPath(maze: maze)
        print("longest path length: \(path.count)")
    }
    
    func setStartPosition(_ position: Position) {
        maze[position]?.value = "🧐"
    }
    
    func solveMaze(start: Position) {
        let path = mazeSolver.solveMaze(
            maze,
            start: start,
            end: Position(maze.rows - 1, maze.cols - 1)
        )
        drawPath(path)
    }
    
    func longestPath() {
        let path = mazeSolver.longestPath(maze: maze)
        drawPath(path)
    }
    
    func colourMaze(start: Position? = nil) {
        let startPosition = start ?? Position(maze.rows/2, maze.cols/2)
        let distances = mazeSolver.generateDistances(
            maze: maze,
            start: startPosition
        )
        for row in 0..<maze.rows {
            for col in 0..<maze.cols {
                let position = Position(row, col)
                if let distance = distances[position], let cell = maze[position] {
                    cell.currentDistance = distance
                }
            }
        }
    }
    
    private func clearMaze() {
        for row in 0..<maze.rows {
            for col in 0..<maze.cols {
                let position = Position(row, col)
                if let cell = maze[position] {
                    cell.value = " "
                }
            }
        }
    }
    
    private func drawPath(_ path: [Position]) {
        clearMaze()
        for i in 0..<path.count {
            let position = path[i]
            let cell = maze[position]!
            if i == 0 {
                cell.value = "😎"
            } else if i == path.count - 1 {
                cell.value = "🧐"
            } else {
                cell.value = "●"
            }
        }
    }
}
