//
//  ContentView.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var rowsValue: Double = 12.0
    @State private var colsValue: Double = 12.0
    @State private var maskedCellCount: Double = 0.0
    @State private var mazeManager = MazeManager()
    @State private var mazeGenerated = false
    @State private var mazeBraided: Bool = false
    @State private var backgroundColorMode: BackgroundColorMode = .none

    var body: some View {
        VStack {
            GridView(
                grid: mazeManager.maze,
                backgroundColorMode: $backgroundColorMode,
                weights: $mazeManager.weights,
                path: $mazeManager.path
            )
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
                    Slider(value: $colsValue, in: 4...12, step: 1)
                        .frame(width: 300)
                    Text("12")
                }
            }
            VStack(spacing: 0) {
                Text("Disallowed Cells: \(Int(maskedCellCount))")
                HStack {
                    Text("0")
                    Slider(value: $maskedCellCount, in: 0...4, step: 1)
                        .frame(width: 300)
                    Text("4")
                }
            }
            VStack(spacing: 10) {
                HStack {
                    Button("Gen (B)") {
                        generateMaze(algorithm: .binaryTree)
                    }
                    .disabled(maskedCellCount > 0)
                    Button("Gen (S)") {
                        generateMaze(algorithm: .sidewinder)
                    }
                    .disabled(maskedCellCount > 0)
                    Button("Gen (A)") {
                        generateMaze(algorithm: .aldousBroder)
                    }
                    Button("Braid") {
                        mazeManager.clearPath()
                        mazeManager.braid()
                        mazeBraided = true
                    }
                    .disabled(!mazeGenerated)
                }
                HStack {
                    Button("Gen (W)") {
                        generateMaze(algorithm: .wilson)
                    }
                    Button("Gen (H)") {
                        generateMaze(algorithm: .hunterKiller)
                    }
                    Button("Gen (R)") {
                        generateMaze(algorithm: .recursiveBacktracker)
                    }
                    Button("Cull") {
                        mazeManager.clearPath()
                        mazeManager.cull()
                    }
                    .disabled(!mazeGenerated)
                }
                HStack {
                    Button("Solve") {
                        mazeManager.solveMaze()
                        backgroundColorMode = .none
                    }
                    .disabled(!mazeGenerated)
                    Button("Longest Path") {
                        mazeManager.longestPath()
                        backgroundColorMode = .none
                    }
                    .disabled(!mazeGenerated || mazeBraided)
                    Button("Colour it!") {
                        mazeManager.calculateWeights()
                        backgroundColorMode = .weight
                    }
                    .disabled(!mazeGenerated)
                    Button("Connections!") {
                        mazeManager.clearPath()
                        backgroundColorMode = .connections
                    }
                    .disabled(!mazeGenerated)
                }
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding()
        .onChange(of: [rowsValue, colsValue, maskedCellCount]) { _ in
            mazeManager.updateGrid(rows: Int(rowsValue), cols: Int(colsValue), maskedCellCount: Int(maskedCellCount))
            mazeGenerated = false
        }
    }
    
    func generateMaze(algorithm: MazeAlgorithm) {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: algorithm)
        backgroundColorMode = .none
        mazeGenerated = true
        mazeBraided = false
    }
}

#Preview {
    ContentView()
}
