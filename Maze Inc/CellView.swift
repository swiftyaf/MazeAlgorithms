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
    let weight: Int?
    let maxWeight: Int?
    let backgroundColorMode: BackgroundColorMode
    let value: String
    
    var body: some View {
        HStack {
            Text(value)
        }
        .frame(width: 30, height: 30)
        .background(backgroundView)
        .overlay {
            CellWalls(walls: walls)
                .stroke(Color(.wall), lineWidth: 2)
        }
    }
    
    var backgroundView: some View {
        switch backgroundColorMode {
        case .weight:
            if let weight, let maxWeight {
                let doubleDistance = Double(weight)
                let doubleMaxDistance = Double(maxWeight)
                let intensity = (doubleMaxDistance - doubleDistance) / doubleMaxDistance
                let dark = 1 * intensity
                let light = 0.5 + 0.5 * intensity
                return Color(red: dark, green: light, blue: light)
            } else {
                return Color.clear
            }
        case .connections:
            return Color(red: 1 - Double(walls.count) * 0.2, green: 0.2, blue: 0.2)
        case .none:
            return Color.clear
        }
    }
}

#Preview {
    CellView(
        walls: [.west, .north],
        cell: Cell(position: Position(0, 0)),
        weight: nil,
        maxWeight: nil,
        backgroundColorMode: .none,
        value: " "
    )
    .padding()
}

enum BackgroundColorMode {
    case weight
    case connections
    case none
}
