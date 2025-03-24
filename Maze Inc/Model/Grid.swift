//
//  Grid.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

@Observable
class Grid { // NW = 0,0
    private var cells: [[Cell]]
    let rows: Int
    let cols: Int
    
    convenience init(size: Int) {
        self.init(rows: size, cols: size)
    }
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        cells = []
        for row in 0..<rows {
            var rowCells: [Cell] = []
            for col in 0..<cols {
                rowCells.append(Cell(position: Position(row, col)))
            }
            cells.append(rowCells)
        }
    }
    
    func cell(at position: Position) -> Cell? {
        guard position.row >= 0, position.row < rows, position.col >= 0, position.col < cols else {
            return nil
        }
        return cells[position.row][position.col]
    }
    
    func cell(nextTo cell: Cell, direction: Direction) -> Cell? {
        let nextCellPosition = Position(cell.position.row + direction.offset.vertical,
                                        cell.position.col + direction.offset.horizontal)
        return self.cell(at: nextCellPosition)
    }
    
    func link(cell1: Cell, cell2: Cell) {
        cell1.link(to: cell2)
        cell2.link(to: cell1)
    }
    
    func wallExists(currentCell: Cell, direction: Direction) -> Bool {
        guard let ajoiningCell = cell(nextTo: currentCell, direction: direction) else {
            return true
        }
        
        return !currentCell.links.contains(where: { $0 === ajoiningCell })
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
    
    func draw() {
        var topWall = ""
        for _ in 0..<cols {
            topWall += "+---"
        }
        topWall += "+"
        print(topWall)

        for row in 0..<rows {
            var rowString = "|"
            var wallString = "+"
            for col in 0..<cols {
                if let cell = cell(at: Position(row, col)) {
                    rowString += " \(cell.value) "
                    if wallExists(currentCell: cell, direction: .east) {
                        rowString += "|"
                    } else {
                        rowString += " "
                    }
                    if wallExists(currentCell: cell, direction: .south) {
                        wallString += "---+"
                    } else {
                        wallString += "   +"
                    }
                }
            }
            print(rowString)
            print(wallString)
        }
    }
}
