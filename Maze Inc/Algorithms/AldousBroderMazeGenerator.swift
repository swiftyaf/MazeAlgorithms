//
//  AldousBroderMazeGenerator.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 25/03/2025.
//

class AldousBroderMazeGenerator: MazeGenerating {
    func generateMaze(in grid: Grid) {
        var unvisited = grid.rows * grid.cols - 1
        var cell = grid.randomCell()
        
        while unvisited > 0 {
            let neighbour = grid.neighbours(of: cell).randomElement()!
            if neighbour.links.isEmpty {
                grid.link(cell1: cell, cell2: neighbour)
                unvisited -= 1
            }
            cell = neighbour
        }
    }
}
