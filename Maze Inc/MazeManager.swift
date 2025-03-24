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
        for position in path {
            let cell = maze.cell(at: position)!
            cell.value = "●"
        }
    }
}
