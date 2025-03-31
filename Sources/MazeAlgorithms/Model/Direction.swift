//
//  Direction.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

public enum Direction: CaseIterable {
    case north
    case east
    case south
    case west
    
    var offset: (horizontal: Int, vertical: Int) {
        switch self {
        case .north:
            return (0, -1)
        case .east:
            return (1, 0)
        case .south:
            return (0, 1)
        case .west:
            return (-1, 0)
        }
    }
}
