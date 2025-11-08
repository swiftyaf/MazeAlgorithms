//
//  MazeAlgorithmsFacade.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import Foundation

/// The main interface for the framework. It has two methods to generate a maze - either in a Grid passed to it or based on desired attributes.
public class MazeAlgorithmsFacade {
    public init() {}
    
    /// Generates a maze inside the Grid passed as parameter
    ///
    /// - Parameters:
    ///   - grid: A `Grid` object where you want the maze to be contained
    ///   - algorithm: Which algorithms to use for maze generation
    public func generateMaze(in grid: Grid, algorithm: MazeAlgorithm) {
        algorithm.generator.generateMaze(in: grid)
    }
    
    public func generateStep() -> Bool {
        return false
    }
    
    /// Creates a grid and then generates a maze into it and returns it
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the grid containing the maze
    ///   - cols: The number of columns in the grid containing the maze
    ///   - maskedCells: An array of cells you want to exclude from the maze
    ///   - algorithm: Which algorithms to use for maze generation
    /// - Returns: A `Grid` object containing the maze
    /// - Throws: `MazeGeneratorError.maskedCellsNotSupported` if the algorithm does not support masked cells.
    public func generateMaze(
        rows: Int,
        cols: Int,
        maskedCells: [Position] = [],
        algorithm: MazeAlgorithm
    ) throws -> Grid {
        if [.binaryTree, .sidewinder].contains(algorithm), !maskedCells.isEmpty {
            throw MazeGeneratorError.maskedCellsNotSupported(algorithm: algorithm)
        }
        let grid = Grid(rows: rows, cols: cols, maskedCells: maskedCells)
        generateMaze(in: grid, algorithm: algorithm)
        return grid
    }

    /// Solves the given maze from a start position to an end position.
    /// - Parameters:
    ///   - maze: The `Grid` object representing the maze.
    ///   - start: The starting `Position` in the maze.
    ///   - end: The ending `Position` in the maze.
    /// - Returns: An array of `Position` objects representing the path from start to end.
    public func solveMaze(maze: Grid, start: Position, end: Position) -> [Position] {
        let solver = MazeSolver()
        return solver.solveMaze(maze, start: start, end: end)
    }

    /// Finds the longest path in the given maze.
    /// - Parameter maze: The `Grid` object representing the maze.
    /// - Returns: An array of `Position` objects representing the longest path.
    public func longestPath(maze: Grid) -> [Position] {
        let solver = MazeSolver()
        return solver.longestPath(maze: maze)
    }

    /// Calculates the weights (distances) of cells in the maze from a given start position.
    /// - Parameters:
    ///   - maze: The `Grid` object representing the maze.
    ///   - start: The starting `Position` from which to calculate weights.
    /// - Returns: A dictionary where keys are `Position` objects and values are their calculated weights (integers).
    public func calculateWeights(maze: Grid, start: Position) -> [Position: Int] {
        let solver = MazeSolver()
        return solver.calculateWeights(maze: maze, start: start)
    }
}
