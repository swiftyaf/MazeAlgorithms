//
//  Cell.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI
import MazeAlgorithms

@Observable
public class Cell {
    public let position: Position
    public var links = [Cell]()

    public init(position: Position) {
        self.position = position
    }
    
    func link(to cell: Cell) {
        links.append(cell)
    }
    
    var passages: [Direction: Bool] {
        [
            .east: links.contains(where: { $0.position.col == position.col+1 }),
            .south: links.contains(where: { $0.position.row == position.row+1 }),
            .west: links.contains(where: { $0.position.col == position.col-1 }),
            .north: links.contains(where: { $0.position.row == position.row-1 })
        ]
    }
}

extension Cell: Identifiable, Equatable {
    public static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.position == rhs.position
    }
}
