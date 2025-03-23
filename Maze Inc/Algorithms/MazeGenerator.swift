//
//  MazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

class MazeGenerator {
    func generateMaze(rows: Int, cols: Int, algorithm: MazeAlgorithm = .binaryTree) -> Grid {
        let grid = Grid(rows: rows, cols: cols)
        switch algorithm {
        case .binaryTree:
            let mazeGenerator = BinaryTreeMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        case .sidewinder:
            let mazeGenerator = SidewinderMazeGenerator()
            mazeGenerator.generateMaze(in: grid)
        }
        return grid
    }
}

enum MazeAlgorithm {
    case binaryTree
    case sidewinder
}
