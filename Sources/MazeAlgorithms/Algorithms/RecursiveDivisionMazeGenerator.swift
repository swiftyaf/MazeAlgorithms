//
//  RecursiveDivisionMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 02/04/2025.
//

class RecursiveDivisionMazeGenerator: MazeGenerating {
    var grid: Grid!
    
    func generateMaze(in grid: Grid) {
        self.grid = grid
        for row in 0..<grid.rows {
            for col in 0..<grid.cols {
                let position = Position(row, col)
                if let cell = grid[position] {
                    for neighbour in grid.neighbours(of: cell) {
                        grid.link(cell1: cell, cell2: neighbour)
                    }
                }
            }
        }
        
        divide(row: 0, col: 0, height: grid.rows, width: grid.cols)
    }
    
    func divide(row: Int, col: Int, height: Int, width: Int) {
        guard height > 1 && width > 1 else { return }
        
        if height > width {
            divideHorizontally(row: row, col: col, height: height, width: width)
        } else {
            divideVertically(row: row, col: col, height: height, width: width)
        }
    }
    
    func divideHorizontally(row: Int, col: Int, height: Int, width: Int) {
        let divideSouthOfRow = Int.random(in: 0..<height-1)
        let passageAt = Int.random(in: 0..<width)
        
        for i in 0..<width {
            if i == passageAt { continue }
            
            let position1 = Position(row+divideSouthOfRow, col+i)
            let position2 = Position(row+divideSouthOfRow+1, col+i)
            let cell = grid[position1]!
            let cell2 = grid[position2]!
            grid.unlink(cell1: cell, cell2: cell2)
        }
        
        divide(row: row, col: col, height: divideSouthOfRow+1, width: width)
        divide(row: row+divideSouthOfRow+1, col: col, height: height-divideSouthOfRow-1, width: width)
    }
    
    func divideVertically(row: Int, col: Int, height: Int, width: Int) {
        let divideEastOfCol = Int.random(in: 0..<width-1)
        let passageAt = Int.random(in: 0..<height)
        
        for i in 0..<height {
            if i == passageAt { continue }
            
            let position1 = Position(row+i, col+divideEastOfCol)
            let position2 = Position(row+i, col+divideEastOfCol+1)
            let cell = grid[position1]!
            let cell2 = grid[position2]!
            grid.unlink(cell1: cell, cell2: cell2)
        }
        
        divide(row: row, col: col, height: height, width: divideEastOfCol+1)
        divide(row: row, col: col+divideEastOfCol+1, height: height, width: width-divideEastOfCol-1)
    }
}
