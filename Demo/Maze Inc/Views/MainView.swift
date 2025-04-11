import MazeAlgorithms
import SwiftUI

struct MainView: View {
    @State private var rowsValue: Double = 12.0
    @State private var colsValue: Double = 12.0
    @State private var maskedCellCount: Double = 0.0
    @State private var mazeManager = MazeManager()
    @State private var mazeGenerated = false
    @State private var mazeBraided = false
    @State private var backgroundColorMode: BackgroundColorMode = .none
    @State private var algorithm: MazeAlgorithm = .recursiveBacktracker
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            GridView(
                grid: mazeManager.maze,
                backgroundColorMode: $backgroundColorMode,
                weights: $mazeManager.weights,
                path: $mazeManager.path
            )
            Spacer()

            GridControlsView(rows: $rowsValue, cols: $colsValue, maskedCells: $maskedCellCount)

            AlgorithmPickerView(algorithm: $algorithm, maskedCellCount: Int(maskedCellCount)) {
                do {
                    try generateMaze()
                } catch {
                    errorMessage = error.localizedDescription
                    showError = true
                }
            }

            MazeActionsView(
                mazeManager: mazeManager,
                mazeGenerated: $mazeGenerated,
                mazeBraided: $mazeBraided,
                backgroundColorMode: $backgroundColorMode
            )
        }
        .padding()
        .alert("Maze Generation Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .onChange(of: rowsValue) { regenerate() }
        .onChange(of: colsValue) { regenerate() }
        .onChange(of: maskedCellCount) { regenerate() }
    }

    private func generateMaze() throws {
        try mazeManager.generateMaze(
            rows: Int(rowsValue),
            cols: Int(colsValue),
            algorithm: algorithm
        )
        backgroundColorMode = .none
        mazeGenerated = true
        mazeBraided = false
    }

    private func regenerate() {
        mazeManager.updateGrid(
            rows: Int(rowsValue),
            cols: Int(colsValue),
            maskedCellCount: Int(maskedCellCount)
        )
        mazeGenerated = false
    }
}

#Preview {
    MainView()
}
