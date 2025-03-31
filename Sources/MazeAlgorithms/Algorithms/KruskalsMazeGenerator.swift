//
//  KruskalsMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 31/03/2025.
//

class KruskalsMazeGenerator: MazeGenerating {
    class State {
        var neighbours: [(Position, Position)] = []
        private var setForCell: [Position: Int] = [:]
        private var cellsInSet: [Int: [Position]] = [:]
        private let grid: Grid
        
        init(grid: Grid) {
            self.grid = grid
            
            for row in 0..<grid.rows {
                for col in 0..<grid.cols {
                    let position = Position(row, col)
                    if let cell = grid[position] {
                        let set = setForCell.count
                        setForCell[position] = set
                        cellsInSet[set, default: []].append(position)
                        if let southCell = grid.cell(nextTo: cell, direction: .south) {
                            neighbours.append((cell.position, southCell.position))
                        }
                        if let eastCell = grid.cell(nextTo: cell, direction: .east) {
                            neighbours.append((cell.position, eastCell.position))
                        }
                    }
                }
            }
        }
        
        func canMerge(_ p: Position, _ q: Position) -> Bool {
            let setP = setForCell[p]!
            let setQ = setForCell[q]!
            return setP != setQ
        }
        
        func merge(_ p: Position, _ q: Position) {
            guard let pCell = grid[p] else { return }
            guard let qCell = grid[q] else { return }
            grid.link(cell1: pCell, cell2: qCell)

            let setP = setForCell[p]!
            let setQ = setForCell[q]!
            
            let qCells = cellsInSet[setQ]!
            for cell in qCells {
                setForCell[cell] = setP
            }
            cellsInSet[setP]?.append(contentsOf: qCells)
            cellsInSet[setQ] = nil
        }
    }
    
    func generateMaze(in grid: Grid) {
        let state = State(grid: grid)
        var neighbours = state.neighbours.shuffled()
        while !neighbours.isEmpty {
            let (p, q) = neighbours.removeLast()
            if state.canMerge(p, q) {
                state.merge(p, q)
            }
        }
    }
}
