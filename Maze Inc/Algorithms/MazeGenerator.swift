//
//  MazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

class MazeGenerator {
    func generateMaze(rows: Int, cols: Int, maskedCells: [Position], algorithm: MazeAlgorithm) -> Grid {
        if [.binaryTree, .sidewinder].contains(algorithm) && !maskedCells.isEmpty {
            fatalError()
        }
        let grid = Grid(rows: rows, cols: cols, maskedCells: maskedCells)
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
        }
        return grid
    }
}

enum MazeAlgorithm: String, CaseIterable {
    case binaryTree = "Binary Tree"
    case sidewinder = "Sidewinder"
    case aldousBroder = "Aldous-Broder"
    case wilson = "Wilson"
    case hunterKiller = "Hunt and Kill"
    case recursiveBacktracker = "Recursive Backtracker"
}
