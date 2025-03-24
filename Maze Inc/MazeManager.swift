//
//  MazeManager.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 24/03/2025.
//

import SwiftUI

@Observable
class MazeManager {
    var maze = Grid(size: 4)
    let mazeGenerator = MazeGenerator()
    let mazeSolver = MazeSolver()

    
    func updateGrid(rows: Int, cols: Int) {
        maze = Grid(rows: rows, cols: cols)
    }
    func generateMaze(rows: Int, cols: Int) {
        maze = mazeGenerator.generateMaze(rows: rows, cols: cols, algorithm: .sidewinder)
    }
    
    func solveMaze() {
        let path = mazeSolver.solveMaze(
            maze,
            start: Position(0, 0),
            end: Position(maze.rows - 1, maze.cols - 1)
        )
        drawPath(path)
    }
    
    func longestPath() {
        let path = mazeSolver.longestPath(maze: maze)
        drawPath(path)
    }
    
    private func drawPath(_ path: [Position]) {
        for i in 0..<path.count {
            let position = path[i]
            let cell = maze.cell(at: position)!
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
