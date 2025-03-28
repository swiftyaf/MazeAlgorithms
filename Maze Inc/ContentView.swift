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
    @State private var backgroundColorMode: BackgroundColorMode = .none

    var body: some View {
        VStack {
            GridView(
                grid: mazeManager.maze,
                backgroundColorMode: $backgroundColorMode,
                distances: $mazeManager.distances,
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
                        generateMazeB()
                        backgroundColorMode = .none
                    }
                    .disabled(maskedCellCount > 0)
                    Button("Gen (S)") {
                        generateMazeS()
                        backgroundColorMode = .none
                    }
                    .disabled(maskedCellCount > 0)
                    Button("Gen (A)") {
                        generateMazeA()
                        backgroundColorMode = .none
                    }
                }
                HStack {
                    Button("Gen (W)") {
                        generateMazeW()
                        backgroundColorMode = .none
                    }
                    Button("Gen (H)") {
                        generateMazeH()
                        backgroundColorMode = .none
                    }
                    Button("Gen (R)") {
                        generateMazeR()
                        backgroundColorMode = .none
                    }
                    Button("Braid") {
                        mazeManager.braid()
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
                    .disabled(!mazeGenerated)
                    Button("Colour it!") {
                        mazeManager.calculateDistances()
                        backgroundColorMode = .distance
                    }
                    .disabled(!mazeGenerated)
                    Button("Connections!") {
                        mazeManager.clearMaze()
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
    
    func generateMazeB() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .binaryTree)
        mazeGenerated = true
    }
    
    func generateMazeS() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .sidewinder)
        mazeGenerated = true
    }
    
    func generateMazeA() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .aldousBroder)
        mazeGenerated = true
    }
    
    func generateMazeW() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .wilson)
        mazeGenerated = true
    }
    
    func generateMazeH() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .hunterKiller)
        mazeGenerated = true
    }
    
    func generateMazeR() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .recursiveBacktracker)
        mazeGenerated = true
    }
}

#Preview {
    ContentView()
}
