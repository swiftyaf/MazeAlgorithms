//
//  GridView.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 24/03/2025.
//

import SwiftUI

struct GridView: View {
    let grid: Grid
    @Binding var backgroundColorMode: BackgroundColorMode
    @Binding var weights: [Position: Int]
    @Binding var path: [Position]
    
    var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(
                    .fixed(25),
                    spacing: 0
                ),
                count: grid.cols
            ),
            spacing: 0
        ) {
            ForEach(0..<(grid.rows * grid.cols), id: \.self) { index in
                let row = index / grid.cols
                let col = index % grid.cols
                if let cell = grid[row, col] {
                    Button {
                        if path.count == 1 && path.first != Position(row, col) {
                            path.append(Position(row, col))
                        } else {
                            path = [Position(row, col)]
                        }
                    } label: {
                        CellView(
                            walls: grid.walls(of: cell),
                            cell: cell,
                            weight: weights[cell.position],
                            maxWeight: weights.values.max() ?? nil,
                            backgroundColorMode: backgroundColorMode,
                            value: value(at: cell.position)
                        )
                    }
                } else { // masked cell
                    Color.clear
                        .frame(width: 25, height: 25)
                    
                }
            }
        }
        .padding()
        .background(Color(.wall))
    }
    
    private func value(at position: Position) -> String {
        guard path.contains(position) else { return " " }
        if position == path.first {
            return "🧐"
        } else if position == path.last {
            return "😎"
        } else {
            return "●"
        }
    }
}

#Preview {
    GridView(
        grid: Grid(rows: 5, cols: 5),
        backgroundColorMode: .constant(.none),
        weights: .constant([:]),
        path: .constant([Position(0, 0), Position(1, 1), Position(2, 2), Position(3, 3), Position(4, 4)])
    )
}
