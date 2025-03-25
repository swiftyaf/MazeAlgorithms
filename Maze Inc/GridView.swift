//
//  GridView.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 24/03/2025.
//

import SwiftUI

struct GridView: View {
    let grid: Grid
    @Binding var startPosition: Position
    
    var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(
                    .fixed(40),
                    spacing: 0
                ),
                count: grid.cols
            ),
            spacing: 0
        ) {
            ForEach(0..<(grid.rows * grid.cols), id: \.self) { index in
                let row = index / grid.cols
                let col = index % grid.cols
                let cell = grid[row, col]!
                
                Button {
                    grid[startPosition]?.value = " "
                    startPosition = Position(row, col)
                    cell.value = "🧐"
                } label: {
                    CellView(walls: grid.walls(of: cell), cell: cell)
                }
            }
        }
        .padding()
    }
}

#Preview {
    GridView(grid: Grid(rows: 5, cols: 5), startPosition: .constant(Position(0, 0)))
}
