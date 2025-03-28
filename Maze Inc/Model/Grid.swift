//
//  Grid.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

@Observable
class Grid { // NW = 0,0
    private let cells: [[Cell]]
    private let maskedCells: [Position]
    let rows: Int
    let cols: Int
    var totalCells: Int {
        rows * cols - maskedCells.count
    }
    
    init(rows: Int, cols: Int, maskedCells: [Position] = [], weights: [Position: Int] = [:]) {
        self.rows = rows
        self.cols = cols
        var cells = [[Cell]]()
        for row in 0..<rows {
            var rowCells: [Cell] = []
            for col in 0..<cols {
                let position = Position(row, col)
                let weight = weights[position] ?? 1
                rowCells.append(Cell(position: position, weight: weight))
            }
            cells.append(rowCells)
        }
        self.cells = cells
        self.maskedCells = maskedCells
    }
    
    subscript(position: Position) -> Cell? {
        self[position.row, position.col]
    }
    
    subscript(row: Int, col: Int) -> Cell? {
        guard row >= 0, row < rows, col >= 0, col < cols else {
            return nil
        }
        guard !maskedCells.contains(where: { $0.row == row && $0.col == col }) else {
            return nil
        }
        return cells[row][col]
    }
    
    func randomCell() -> Cell {
        let randomRow = Int.random(in: 0..<rows)
        let randomCol = Int.random(in: 0..<cols)
        return self[randomRow, randomCol] ?? randomCell()
    }
    
    func cell(nextTo cell: Cell, direction: Direction) -> Cell? {
        let nextCellPosition = Position(cell.position.row + direction.offset.vertical,
                                        cell.position.col + direction.offset.horizontal)
        return self[nextCellPosition]
    }
    
    func neighbours(of cell: Cell) -> [Cell] {
        var neighbours: [Cell] = []
        for direction in Direction.allCases {
            if let neighbour = self.cell(nextTo: cell, direction: direction) {
                neighbours.append(neighbour)
            }
        }
        return neighbours
    }
    
    func link(cell1: Cell, cell2: Cell) {
        cell1.link(to: cell2)
        cell2.link(to: cell1)
    }
    
    func wallExists(currentCell: Cell, direction: Direction) -> Bool {
        guard let neighbour = cell(nextTo: currentCell, direction: direction) else {
            return true
        }
        
        return !currentCell.links.contains(where: { $0 === neighbour })
    }
    
    func walls(of cell: Cell) -> [Direction] {
        var directions: [Direction] = []
        if wallExists(currentCell: cell, direction: .north) {
            directions.append(.north)
        }
        if wallExists(currentCell: cell, direction: .east) {
            directions.append(.east)
        }
        if wallExists(currentCell: cell, direction: .south) {
            directions.append(.south)
        }
        if wallExists(currentCell: cell, direction: .west) {
            directions.append(.west)
        }
        return directions
    }
    
    func deadends() -> [Cell] {
        cells.flatMap { $0 }.filter { $0.links.count == 1 }
    }
    
    func braid(p: Int = 10) {
        let deadends = deadends().shuffled()
        deadends.forEach { deadend in
            if deadend.links.count == 1 && Int.random(in: 0..<10) < p {
                let neighbours = neighbours(of: deadend)
                    .filter { !$0.links.contains(where: { $0 === deadend }) }
                let bestNeighbours: [Cell]
                let deadendNeighbours = neighbours.filter { $0.links.count == 1 }
                bestNeighbours = deadendNeighbours.isEmpty ? neighbours : deadendNeighbours
                let randomNeighbour = bestNeighbours.randomElement()!
                link(cell1: deadend, cell2: randomNeighbour)
            }
        }
    }
}
