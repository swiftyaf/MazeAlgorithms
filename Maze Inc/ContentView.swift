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
    @State private var mazeManager = MazeManager()
    @State private var mazeGenerated = false
    @State private var startPosition = Position(0, 0)
    @State private var backgroundColorMode: BackgroundColorMode = .none

    var body: some View {
        VStack {
            GridView(
                grid: mazeManager.maze,
                startPosition: $startPosition,
                backgroundColorMode: $backgroundColorMode,
                distances: $mazeManager.distances
            )
            Spacer()
            VStack(spacing: 0) {
                Text("Rows: \(Int(rowsValue))")
                HStack {
                    Text("4")
                    Slider(value: $rowsValue, in: 4...15, step: 1)
                        .frame(width: 300)
                    Text("15")
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
            VStack(spacing: 10) {
                HStack {
                    Button("Gen (B)") {
                        generateMazeB()
                        backgroundColorMode = .none
                    }
                    Button("Gen (S)") {
                        generateMazeS()
                        backgroundColorMode = .none
                    }
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
                }
                HStack {
                    Button("Solve") {
                        mazeManager.solveMaze(start: startPosition)
                        backgroundColorMode = .none
                    }
                    .disabled(!mazeGenerated)
                    Button("Longest Path") {
                        mazeManager.longestPath()
                        backgroundColorMode = .none
                    }
                    .disabled(!mazeGenerated)
                    Button("Colour it!") {
                        mazeManager.calculateDistances(start: startPosition)
                        backgroundColorMode = .distance
                    }
                    .disabled(!mazeGenerated)
                    Button("Connections!") {
                        backgroundColorMode = .connections
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
        mazeManager.setStartPosition(startPosition)
        mazeGenerated = true
    }
    
    func generateMazeS() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .sidewinder)
        mazeManager.setStartPosition(startPosition)
        mazeGenerated = true
    }
    
    func generateMazeA() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .aldousBroder)
        mazeManager.setStartPosition(startPosition)
        mazeGenerated = true
    }
    
    func generateMazeW() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .wilson)
        mazeManager.setStartPosition(startPosition)
        mazeGenerated = true
    }
    
    func generateMazeH() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .hunterKiller)
        mazeManager.setStartPosition(startPosition)
        mazeGenerated = true
    }
    
    func generateMazeR() {
        mazeManager.generateMaze(rows: Int(rowsValue), cols: Int(colsValue), algorithm: .recursiveBacktracker)
        mazeManager.setStartPosition(startPosition)
        mazeGenerated = true
    }
}

#Preview {
    ContentView()
}
