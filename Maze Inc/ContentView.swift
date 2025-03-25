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
    @State private var mazeGenerated = false
    @State private var startPosition = Position(0, 0)

    var body: some View {
        VStack {
            GridView(grid: mazeManager.maze, startPosition: $startPosition)
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
            VStack(spacing: 10) {
                HStack {
                    Button("Generate (BTree)") {
                        generateMazeB()
                    }
                    Button("Generate (SideW)") {
                        generateMazeS()
                    }
                }
                HStack {
                    Button("Solve Maze") {
                        mazeManager.solveMaze(start: startPosition)
                    }
                    .disabled(!mazeGenerated)
                    Button("Longest Path") {
                        mazeManager.longestPath()
                    }
                    .disabled(!mazeGenerated)
                }
                HStack {
                    Button("Colour it!") {
                        mazeManager.colourMaze(start: startPosition)
                    }
                    .disabled(!mazeGenerated)
                }
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding()
        .onChange(of: [rowsValue, colsValue]) { _ in
            mazeManager.updateGrid(rows: Int(rowsValue), cols: Int(colsValue))
            mazeGenerated = false
        }
    }
    
    func generateMazeB() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .binaryTree)
        mazeGenerated = true
    }
    
    func generateMazeS() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .sidewinder)
        mazeGenerated = true
    }
}

#Preview {
    ContentView()
}
