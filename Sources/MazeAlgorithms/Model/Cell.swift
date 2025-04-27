//
//  Cell.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

@Observable
public class Cell: Hashable, CustomStringConvertible {
    public let position: Position
    public var links = Set<Cell>()
    public var description: String { "\(position)" }

    public init(position: Position) {
        self.position = position
    }
    
    func link(to cell: Cell) {
        links.insert(cell)
    }
    
    var passages: [Direction: Bool] {
        [
            .east: links.contains(where: { $0.position.col == position.col+1 }),
            .south: links.contains(where: { $0.position.row == position.row+1 }),
            .west: links.contains(where: { $0.position.col == position.col-1 }),
            .north: links.contains(where: { $0.position.row == position.row-1 })
        ]
    }
    
    public static func == (lhs: Cell, rhs: Cell) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
