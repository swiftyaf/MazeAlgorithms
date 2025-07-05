//
//  MazeManager.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 24/03/2025.
//

import SwiftUI
import MazeAlgorithms

@Observable
class MazeManager {
    var maze: MazeAlgorithms.Grid
    let mazeFacade = MazeAlgorithmsFacade()
    var weights = [Position: Int]()
    var path = [Position(0, 0)]
    var maskedCells: [Position] = []
    var currentGenerator: MazeGenerating?
    var nextStep: (generated: [Cell], evaluating: [Cell])?
    
    init() {
        let maze = MazeAlgorithms.Grid(rows: 12, cols: 12)
        self.maze = maze
    }

    func updateGrid(rows: Int, cols: Int) {
        maze = Grid(rows: rows, cols: cols)
        clearMaze()
        weights = [:]
        currentGenerator = nil
    }
    
    func generateMaze(rows: Int, cols: Int, algorithm: MazeAlgorithm) throws {
        maze = try mazeFacade.generateMaze(
            rows: rows,
            cols: cols,
            algorithm: algorithm
        )
        clearMaze()
        let deadends = maze.deadendCells
        print("deadends: \(deadends.count)")
        let longestPathResult = mazeFacade.longestPath(maze: maze)
        print("longest path length: \(longestPathResult.count)")
    }
    
    func generateMaze(algorithm: MazeAlgorithm) {
        clearMaze()
        mazeFacade.generateMaze(in: maze, algorithm: algorithm)
        let deadends = maze.deadendCells
        print("deadends: \(deadends.count)")
        let longestPathResult = mazeFacade.longestPath(maze: maze)
        print("longest path length: \(longestPathResult.count)")
    }
    
    func generateStep(algorithm: MazeAlgorithm) -> Bool {
        if currentGenerator == nil {
            currentGenerator = algorithm.generator
            currentGenerator?.setGrid(maze)
        }
        
        nextStep = currentGenerator?.generateStep()
        return nextStep != nil
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

        path = mazeFacade.solveMaze(
            maze: maze,
            start: start,
            end: end
        ).reversed()
    }

    func longestPath() {
        path = mazeFacade.longestPath(maze: maze)
        print("longest path length: \(path.count)")
    }
    
    func calculateWeights() {
        guard let startPosition = path.first else {
            weights = [:]
            return
        }
        weights = mazeFacade.calculateWeights(
            maze: maze,
            start: startPosition
        )
    }
    
    func braid() {
        maze.braid(p: 5)
    }
    
    func cull() {
        maze.cull(ignoring: path)
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
    
    func clearPath() {
        if path.count > 2 {
            path = [path.first!, path.last!]
        }
    }
}
