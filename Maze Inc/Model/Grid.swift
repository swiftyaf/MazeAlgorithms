//
//  Grid.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

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
                rowCells.append(Cell(row: row, col: col))
            }
            cells.append(rowCells)
        }
    }
    
    func cell(at row: Int, _ col: Int) -> Cell? {
        guard row >= 0, row < cells.count, col >= 0, col < cells[row].count else {
            return nil
        }
        return cells[row][col]
    }
    
    func cell(nextTo cell: Cell, direction: Direction) -> Cell? {
        self.cell(
            at: cell.row + direction.offset.vertical,
            cell.col + direction.offset.horizontal
        )
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
                if let cell = cell(at: row, col) {
                    rowString += "   "
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
