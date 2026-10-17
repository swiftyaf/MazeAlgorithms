//
//  RecursiveBacktrackerMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 26/03/2025.
//

public class RecursiveBacktrackerMazeGenerator: MazeGenerating {
    var grid: Grid
    var generating = false
    private var stack: [Cell] = []
    private let seed: UInt64?
    private var seededGenerator: SeededRandomNumberGenerator?
    
    /// - Parameter seed: When set, every generation run produces the same maze for the same
    ///   grid size; when `nil`, the system random number generator is used.
    public init(grid: Grid = Grid(rows: 10, cols: 10), seed: UInt64? = nil) {
        self.grid = grid
        self.seed = seed
    }
    
    public func setGrid(_ grid: Grid) {
        self.grid = grid
        generating = false
    }
    
    public func generateStep() -> (generated: [Cell], evaluating: [Cell])? {
        if !generating {
            generating = true
            if let seed {
                // Restart the sequence on each run so repeated runs are identical
                var generator = SeededRandomNumberGenerator(seed: seed)
                stack = [grid.randomCell(using: &generator)]
                seededGenerator = generator
            } else {
                stack = [grid.randomCell()]
            }
        }

        if stack.isEmpty {
            generating = false
            return nil
        }
        
        let current = stack.last!
        let unvisitedNeighbours = grid.neighbours(of: current).filter { $0.links.isEmpty }
        if unvisitedNeighbours.isEmpty {
            _ = stack.popLast()
        } else {
            let neighbour: Cell
            if var generator = seededGenerator {
                neighbour = generator.element(of: unvisitedNeighbours)!
                seededGenerator = generator
            } else {
                neighbour = unvisitedNeighbours.randomElement()!
            }
            grid.link(cell1: current, cell2: neighbour)
            stack.append(neighbour)
        }
        return (generated: [current], evaluating: stack)
    }
    
    public func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateStep() != nil {}
    }
}
