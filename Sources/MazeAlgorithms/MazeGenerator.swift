//
//  MazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import Foundation

/// The main interface for the framework. It has two methods to generate a maze - either in a Grid passed to it or based on desired attributes.
public class MazeGenerator {
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
}

public enum MazeAlgorithm: String, CaseIterable, Sendable, Identifiable {
    public var id: String {
        self.rawValue
    }
    
    case binaryTree = "Binary Tree"
    case sidewinder = "Sidewinder"
    case aldousBroder = "Aldous-Broder"
    case wilson = "Wilson"
    case hunterKiller = "Hunt and Kill"
    case recursiveBacktracker = "Recursive Backtracker"
    case kruskal = "Randomised Kruskal's"
    case simplifiedPrim = "Simplified Prim"
    case modifiedPrim = "Modified Prim"
    case prim = "Prim"
    case growingTree = "Growing Tree"
    case ellers = "Eller's"
    case recursiveDivision = "Recursive Division"

    public var generator: MazeGenerating {
        switch self {
        case .binaryTree: BinaryTreeMazeGenerator()
        case .sidewinder: SidewinderMazeGenerator()
        case .aldousBroder: AldousBroderMazeGenerator()
        case .wilson: WilsonMazeGenerator()
        case .hunterKiller: HunterKillerMazeGenerator()
        case .recursiveBacktracker: RecursiveBacktrackerMazeGenerator()
        case .kruskal: KruskalsMazeGenerator()
        case .simplifiedPrim: SimplifiedPrimMazeGenerator()
        case .prim: PrimMazeGenerator()
        case .growingTree: GrowingTreeMazeGenerator()
        case .modifiedPrim: ModifiedPrimMazeGenerator()
        case .ellers: EllersMazeGenerator()
        case .recursiveDivision: RecursiveDivisionMazeGenerator()
        }
    }
}
