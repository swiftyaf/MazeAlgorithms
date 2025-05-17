//
//  RecursiveDivisionMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 02/04/2025.
//

public class RecursiveDivisionMazeGenerator: MazeGenerating {
    struct State {
        let row: Int
        let col: Int
        let height: Int
        let width: Int
    }
    
    var grid: Grid
    var generating = false

    var stack: [State] = []
    
    public init(grid: Grid = Grid(rows: 10, cols: 10)) {
        self.grid = grid
    }
    
    public func setGrid(_ grid: Grid) {
        self.grid = grid
        generating = false
    }

    public func generateStep() -> (generated: [Cell], evaluating: [Cell])? {
        var current: [Cell] = []
        var next: [Cell] = []
        
        if !generating {
            generating = true
            linkAllCells()
            stack.append(State(row: 0, col: 0, height: grid.rows, width: grid.cols))
        }
        
        guard !stack.isEmpty else {
            return nil
        }
        
        let state = stack.removeLast()
        guard state.height > 1 && state.width > 1 else {
            return (generated: [], evaluating: [])
        }
        
        
        
        if state.height > state.width {
            let divideSouthOfRow = Int.random(in: 0..<state.height-1)
            let passageAt = Int.random(in: 0..<state.width)
            
            for i in 0..<state.width {
                if i == passageAt { continue }
                
                let position1 = Position(state.row+divideSouthOfRow, state.col+i)
                let position2 = Position(state.row+divideSouthOfRow+1, state.col+i)
                let cell = grid[position1]!
                let cell2 = grid[position2]!
                grid.unlink(cell1: cell, cell2: cell2)
                next.append(cell)
                next.append(cell2)
            }
            
            stack.append(
                State(
                    row: state.row,
                    col: state.col,
                    height: divideSouthOfRow+1,
                    width: state.width
                )
            )
            stack.append(
                State(
                    row: state.row+divideSouthOfRow+1,
                    col: state.col,
                    height: state.height-divideSouthOfRow-1,
                    width: state.width
                )
            )
        } else {
            let divideEastOfCol = Int.random(in: 0..<state.width-1)
            let passageAt = Int.random(in: 0..<state.height)
            
            for i in 0..<state.height {
                if i == passageAt { continue }
                
                let position1 = Position(state.row+i, state.col+divideEastOfCol)
                let position2 = Position(state.row+i, state.col+divideEastOfCol+1)
                let cell = grid[position1]!
                let cell2 = grid[position2]!
                grid.unlink(cell1: cell, cell2: cell2)
                next.append(cell)
                next.append(cell2)
            }
            
            stack.append(
                State(
                    row: state.row,
                    col: state.col,
                    height: state.height,
                    width: divideEastOfCol+1
                )
            )
            stack.append(
                State(
                    row: state.row,
                    col: state.col+divideEastOfCol+1,
                    height: state.height,
                    width: state.width-divideEastOfCol-1
                )
            )
        }
        return (generated: current, evaluating: next)
    }
    
    public func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateStep() != nil {}
    }
    
    private func linkAllCells() {
        grid.allCells.forEach { cell in
            for neighbour in grid.neighbours(of: cell) {
                grid.link(cell1: cell, cell2: neighbour)
            }
        }
    }
        
    private func divide() {
        while !stack.isEmpty {
            let state = stack.removeLast()
            guard state.height > 1 && state.width > 1 else { continue }
            
            if state.height > state.width {
                let divideSouthOfRow = Int.random(in: 0..<state.height-1)
                let passageAt = Int.random(in: 0..<state.width)
                
                for i in 0..<state.width {
                    if i == passageAt { continue }
                    
                    let position1 = Position(state.row+divideSouthOfRow, state.col+i)
                    let position2 = Position(state.row+divideSouthOfRow+1, state.col+i)
                    let cell = grid[position1]!
                    let cell2 = grid[position2]!
                    grid.unlink(cell1: cell, cell2: cell2)
                }
                
                stack.append(
                    State(
                        row: state.row,
                        col: state.col,
                        height: divideSouthOfRow+1,
                        width: state.width
                    )
                )
                stack.append(
                    State(
                        row: state.row+divideSouthOfRow+1,
                        col: state.col,
                        height: state.height-divideSouthOfRow-1,
                        width: state.width
                    )
                )
            } else {
                let divideEastOfCol = Int.random(in: 0..<state.width-1)
                let passageAt = Int.random(in: 0..<state.height)
                
                for i in 0..<state.height {
                    if i == passageAt { continue }
                    
                    let position1 = Position(state.row+i, state.col+divideEastOfCol)
                    let position2 = Position(state.row+i, state.col+divideEastOfCol+1)
                    let cell = grid[position1]!
                    let cell2 = grid[position2]!
                    grid.unlink(cell1: cell, cell2: cell2)
                }
                
                stack.append(
                    State(
                        row: state.row,
                        col: state.col,
                        height: state.height,
                        width: divideEastOfCol+1
                    )
                )
                stack.append(
                    State(
                        row: state.row,
                        col: state.col+divideEastOfCol+1,
                        height: state.height,
                        width: state.width-divideEastOfCol-1
                    )
                )
            }
        }
    }
}
