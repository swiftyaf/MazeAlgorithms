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
    let distance: Int?
    let backgroundColorMode: BackgroundColorMode
    
    var body: some View {
        HStack {
            Text(cell.value)
        }
        .frame(width: 30, height: 30)
        .background(backgroundView)
        .overlay {
            CellWalls(walls: walls)
                .stroke(Color.black, lineWidth: 2)
        }
    }
    
    var backgroundView: some View {
        switch backgroundColorMode {
        case .distance:
            if let distance {
                let maxDistance: Double = 30
                let normalisedDistance = min(Double(distance), maxDistance)
                let intensity = (maxDistance - normalisedDistance) / maxDistance
                let dark = 1 * intensity
                let light = 0.5 + 0.5 * intensity
                return Color(red: dark, green: light, blue: light)
            } else {
                return Color.clear
            }
        case .connections:
            return Color(red: 1 - Double(walls.count) * 0.15, green: 0.2, blue: 0.2)
        case .none:
            return Color.clear
        }
    }
}

#Preview {
    CellView(
        walls: [.west, .north],
        cell: Cell(position: Position(0, 0)),
        distance: nil,
        backgroundColorMode: .none
    )
    .padding()
}

enum BackgroundColorMode {
    case distance
    case connections
    case none
}
