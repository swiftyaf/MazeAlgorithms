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
        .overlay {
            CellWalls(walls: walls)
                .stroke(Color.blue, lineWidth: 2)
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
