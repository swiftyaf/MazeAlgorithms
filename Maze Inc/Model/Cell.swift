//
//  Cell.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

class Cell {
    let row: Int
    let col: Int
    
    var links = [Cell]()

    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    func link(to cell: Cell) {
        links.append(cell)
    }
    
    func unlink(from cell: Cell) {
        links.removeAll { $0 === cell }
        cell.unlink(from: self)
    }
}
