//
//  SidewinderMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

class SidewinderMazeGenerator: MazeGenerating {
    func generateMaze(in grid: Grid) {
        for row in 0..<grid.rows {
            var run = [Cell]()
            for col in 0..<grid.cols {
                if let cell = grid[row, col] {
                    run.append(cell)
                    let atEastEdgeOfGrid = col == grid.cols - 1
                    let atNorthEdgeOfGrid = row == 0
                    let shouldCloseOut = atEastEdgeOfGrid
                    || (!atNorthEdgeOfGrid && Int.random(in: 0...1) == 0)
                    
                    if shouldCloseOut {
                        let randomCell = run.randomElement()!
                        if let northCell = grid.cell(nextTo: randomCell, direction: .north) {
                            grid.link(cell1: randomCell, cell2: northCell)
                        }
                        run = []
                    } else {
                        if let eastCell = grid.cell(nextTo: cell, direction: .east) {
                            grid.link(cell1: cell, cell2: eastCell)
                        }
                    }
                }
            }
        }
    }
}
