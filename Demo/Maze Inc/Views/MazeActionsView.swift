//  MazeActionsView.swift

import SwiftUI

struct MazeActionsView: View {
    var mazeManager: MazeManager
    @Binding var mazeGenerated: Bool
    @Binding var mazeBraided: Bool
    @Binding var backgroundColorMode: BackgroundColorMode

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button("Braid") {
                    mazeManager.clearPath()
                    mazeManager.braid()
                    mazeBraided = true
                }
                .disabled(!mazeGenerated)

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
}
