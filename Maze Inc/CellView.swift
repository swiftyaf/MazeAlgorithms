//
//  CellView.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

struct CellView: View {
    let walls: [Direction]
    let cell: Cell
    
    var body: some View {
        HStack {
            Text(cell.value)
        }
        .frame(width: 40, height: 40)
        .background(backgroundForCell(cell))
        .overlay {
            CellWalls(walls: walls)
                .stroke(Color.black, lineWidth: 2)
        }
    }
    
    func backgroundForCell(_ cell: Cell) -> some View {
        if let distance = cell.currentDistance {
            let maxDistance: Double = 30
            let normalisedDistance = min(Double(distance), maxDistance)
            let intensity = (maxDistance - normalisedDistance) / maxDistance
            let dark = 1 * intensity
            let light = 0.5 + 0.5 * intensity
            return Color(red: dark, green: light, blue: light)
        } else {
            return Color.clear
        }
    }
}

#Preview {
    CellView(
        walls: [.west, .north],
        cell: Cell(position: Position(0, 0))
    )
        .padding()
}
