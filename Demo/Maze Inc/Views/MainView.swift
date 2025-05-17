import MazeAlgorithms
import SwiftUI
import Combine

struct MainView: View {
    @State private var rowsValue: Double = 12.0
    @State private var colsValue: Double = 12.0
    @State private var mazeManager = MazeManager()
    @State private var mazeGenerated = false
    @State private var mazeBraided = false
    @State private var backgroundColorMode: BackgroundColorMode = .none
    @State private var algorithm: MazeAlgorithm = .recursiveBacktracker
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showSettings: Bool = false
    @State private var generatingInProgress = false
    private let timer = Timer.publish(every: 0.04, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                GridView(
                    grid: mazeManager.maze,
                    backgroundColorMode: $backgroundColorMode,
                    weights: $mazeManager.weights,
                    path: $mazeManager.path,
                    cellActivity: $mazeManager.nextStep
                )
                Spacer()
                
                GridControlsView(rows: $rowsValue, cols: $colsValue)
                
                HStack {
                    Button("Generate") {
                        do {
                            try generateMaze()
                        } catch {
                            errorMessage = error.localizedDescription
                            showError = true
                        }
                    }
                    Button("Animate") {
                        animateGeneration()
                    }
                }
                .disabled(generatingInProgress)
                
                MazeActionsView(
                    mazeManager: mazeManager,
                    mazeGenerated: $mazeGenerated,
                    mazeBraided: $mazeBraided,
                    backgroundColorMode: $backgroundColorMode
                )
            }
            .padding()
            SettingsView(isShowing: $showSettings, selectedAlgorithm: $algorithm)
        }
        .alert("Maze Generation Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .onChange(of: rowsValue) { resetGrid() }
        .onChange(of: colsValue) { resetGrid() }
        .onChange(of: algorithm) { resetGrid() }
        .onReceive(timer) { _ in
            if generatingInProgress {
                if !mazeManager.generateStep(algorithm: algorithm) {
                    mazeGenerated = true
                    generatingInProgress = false
                }
            }
        }
    }
    
    private func animateGeneration() {
        if mazeGenerated {
            resetGrid()
        }
        generatingInProgress = true
    }
    
    private func generateMaze() throws {
        if mazeGenerated {
            resetGrid()
        }
        mazeManager.generateMaze(algorithm: algorithm)
        backgroundColorMode = .none
        mazeGenerated = true
        mazeBraided = false
    }
    
    private func resetGrid() {
        mazeManager.updateGrid(
            rows: Int(rowsValue),
            cols: Int(colsValue)
        )
        mazeGenerated = false
    }
}

#Preview {
    MainView()
}
