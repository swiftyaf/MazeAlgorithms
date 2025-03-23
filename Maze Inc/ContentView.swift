//
//  ContentView.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var rowsValue: Double = 4.0
    @State private var colsValue: Double = 4.0

    var body: some View {
        VStack {
            HStack {
                Text("Rows")
                Slider(value: $rowsValue, in: 4...12, step: 1)
                    .frame(width: 300)
                    .padding()
                
                Text("\(Int(rowsValue))")
            }
            HStack {
                Text("Columns")
                Slider(value: $colsValue, in: 4...12, step: 1)
                    .frame(width: 300)
                    .padding()
                
                Text("\(Int(colsValue))")
            }
            Button("Generate Maze") {
                generateMaze()
            }
        }
        .padding()
    }
    
    func generateMaze() {
        let grid = Grid(rows: Int(rowsValue), cols: Int(colsValue))
        let mazeAlgo = BinaryTreeMazeAlgorithm()
        mazeAlgo.generateMaze(in: grid)
        grid.draw()
    }
}

#Preview {
    ContentView()
}
