//
//  CellWalls.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

struct CellWalls: Shape {
    let walls: [Direction]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        if walls.contains(.west) {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
        
        if walls.contains(.north) {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        }
        
        if walls.contains(.east) {
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        }
        
        if walls.contains(.south) {
            path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
        
        return path
    }
}
