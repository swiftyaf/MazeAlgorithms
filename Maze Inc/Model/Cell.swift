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
    let weight: Int
    var links = [Cell]()

    init(position: Position, weight: Int) {
        self.position = position
        self.weight = weight
    }
    
    func link(to cell: Cell) {
        links.append(cell)
    }
}
