//
//  Cell.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

@Observable
class Cell {
    let position: Position
    var value: String = " "
    var currentDistance: Int?
    
    var links = [Cell]()

    init(position: Position) {
        self.position = position
    }
    
    func link(to cell: Cell) {
        links.append(cell)
    }
    
    func unlink(from cell: Cell) {
        links.removeAll { $0 === cell }
        cell.unlink(from: self)
    }
}
