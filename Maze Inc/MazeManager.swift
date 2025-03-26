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
    var maskedCells: [Position] = []

    func updateGrid(rows: Int, cols: Int, maskedCellCount: Int) {
        maskedCells = []
        if maskedCellCount > 0 {
            let randomIndex = Array(0..<rows*cols)
            let randomValues = Array(randomIndex.shuffled().prefix(maskedCellCount))
            for value in randomValues {
                let position = Position(value / cols, value % cols)
                maskedCells.append(position)
            }
        }

        maze = Grid(rows: rows, cols: cols, maskedCells: maskedCells)
        clearMaze()
        distances = [:]
    }
    
    func generateMaze(rows: Int, cols: Int, algorithm: MazeAlgorithm) {
        clearMaze()
        maze = mazeGenerator.generateMaze(
            rows: rows,
            cols: cols,
            maskedCells: maskedCells,
            algorithm: algorithm
        )
        let deadends = maze.deadends()
        print("deadends: \(deadends.count)")
        let longestPath = mazeSolver.longestPath(maze: maze)
        print("longest path length: \(longestPath.count)")
    }
    
    func solveMaze() {
        let start = path.first!
        let end: Position = {
            if path.last! != path.first! {
                return path.last!
            } else {
                var randomCell = maze.randomCell()
                while randomCell.position == start {
                    randomCell = maze.randomCell()
                }
                return randomCell.position
            }}()
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
        for row in 0..<maze.rows {
            for col in 0..<maze.cols {
                if maze[row, col] != nil {
                    path = [Position(row, col)]
                    return
                }
            }
        }
    }
}
