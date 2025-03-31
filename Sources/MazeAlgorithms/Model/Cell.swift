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
}

extension Cell: Identifiable, Equatable {
    public static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.position == rhs.position
    }
}
