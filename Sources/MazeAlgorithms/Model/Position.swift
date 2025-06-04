//
//  Position.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 24/03/2025.
//

public struct Position: Hashable, CustomStringConvertible {
    public let row: Int
    public let col: Int
    public var description: String { "(\(row), \(col))" }
    
    public init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
}
