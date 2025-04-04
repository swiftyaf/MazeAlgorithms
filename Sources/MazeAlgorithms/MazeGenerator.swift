//
//  MazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

/// The main interface for the framework. It has two methods to generate a maze - either in a Grid passed to it or based on desired attributes.
public class MazeGenerator {
    public init() {}
    
    /// Generates a maze inside the Grid passed as parameter
    /// - Parameters:
    ///   - grid: A Grid object where you want the maze to be contained
    ///   - algorithm: Which algorithms to use for maze generation
    public func generateMaze(in grid: Grid, algorithm: MazeAlgorithm) {
        switch algorithm {
        case .binaryTree:
            let mazeGenerator = BinaryTreeMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .sidewinder:
            let mazeGenerator = SidewinderMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .aldousBroder:
            let mazeGenerator = AldousBroderMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .wilson:
            let mazeGenerator = WilsonMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .hunterKiller:
            let mazeGenerator = HunterKillerMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .recursiveBacktracker:
            let mazeGenerator = RecursiveBacktrackerMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .kruskal:
            let mazeGenerator = KruskalsMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .simplifiedPrim:
            let mazeGenerator = SimplifiedPrimMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .prim:
            let mazeGenerator = PrimMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .growingTree:
            let mazeGenerator = GrowingTreeMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .modifiedPrim:
            let mazeGenerator = ModifiedPrimMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .ellers:
            let mazeGenerator = EllersMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .recursiveDivision:
            let mazeGenerator = RecursiveDivisionMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        }
    }
    
    /// Creates a grid and then generates a maze into it and returns it
    /// - Parameters:
    ///   - rows: The number of rows in the grid containing the maze
    ///   - cols: The number of columns in the grid containing the maze
    ///   - maskedCells: An array of cells you want to exclude from the maze
    ///   - algorithm: Which algorithms to use for maze generation
    /// - Returns: A Grid object containing the maze
    public func generateMaze(
        rows: Int,
        cols: Int,
        maskedCells: [Position] = [],
        algorithm: MazeAlgorithm
    ) -> Grid {
        if [.binaryTree, .sidewinder].contains(algorithm) && !maskedCells.isEmpty {
            fatalError()
        }
        let grid = Grid(rows: rows, cols: cols, maskedCells: maskedCells)
        generateMaze(in: grid, algorithm: algorithm)
        return grid
    }
}

public enum MazeAlgorithm: String, CaseIterable, Sendable {
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
}
