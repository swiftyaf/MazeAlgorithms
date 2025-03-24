//
//  Position.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 24/03/2025.
//

struct Position: Hashable {
    let row: Int
    let col: Int
    
    init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
}
