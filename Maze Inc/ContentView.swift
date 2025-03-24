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
    @State private var mazeManager = MazeManager()
    

    var body: some View {
        VStack {
            GridView(grid: mazeManager.maze)
            Spacer()
            VStack(spacing: 0) {
                Text("Rows: \(Int(rowsValue))")
                HStack {
                    Text("4")
                    Slider(value: $rowsValue, in: 4...12, step: 1)
                        .frame(width: 300)
                    Text("12")
                }
            }
            VStack(spacing: 0) {
                Text("Columns: \(Int(colsValue))")
                HStack {
                    Text("4")
                    Slider(value: $colsValue, in: 4...9, step: 1)
                        .frame(width: 300)
                    Text("9")
                }
            }
            Button("Generate Maze") {
                generateMaze()
            }
        }
        .padding()
        .onChange(of: [rowsValue, colsValue]) { _ in
            mazeManager.updateGrid(rows: Int(rowsValue), cols: Int(colsValue))
        }
    }
    
    func generateMaze() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue))
    }
    
    }
}

#Preview {
    ContentView()
}
