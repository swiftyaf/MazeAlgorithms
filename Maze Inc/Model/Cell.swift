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
    var links = [Cell]()

    init(position: Position) {
        self.position = position
    }
    
    func link(to cell: Cell) {
        links.append(cell)
    }
}
