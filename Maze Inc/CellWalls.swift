//
//  CellWalls.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

struct CellWalls: Shape {
    let walls: [Direction]
    let margin: CGFloat
    let width: CGFloat = 1
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let minX = rect.minX
        let minY = rect.minY
        let maxX = rect.maxX
        let maxY = rect.maxY
        
        if walls.contains(.west) {
            path.move(to: CGPoint(x: minX + margin, y: minY))
            path.addLine(to: CGPoint(x: minX + margin, y: maxY))
        }
        
        if walls.contains(.north) {
            path.move(to: CGPoint(x: minX, y: minY + margin))
            path.addLine(to: CGPoint(x: maxX, y: minY + margin))
        }
        
        if walls.contains(.east) {
            path.move(to: CGPoint(x: maxX - margin, y: minY))
            path.addLine(to: CGPoint(x: maxX - margin, y: maxY))
        }
        
        if walls.contains(.south) {
            path.move(to: CGPoint(x: maxX, y: maxY - margin))
            path.addLine(to: CGPoint(x: minX, y: maxY - margin))
        }
        
        return path
    }
}
