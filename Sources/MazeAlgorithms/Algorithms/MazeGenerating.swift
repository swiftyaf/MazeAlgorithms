//
//  MazeGenerating.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

public protocol MazeGenerating {
    func setGrid(_ grid: Grid)
    func generateMaze(in grid: Grid)
    func generateStep() -> (generated: [Cell], evaluating: [Cell])?
}

