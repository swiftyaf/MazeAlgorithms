//  AlgorithmPickerView.swift

import MazeAlgorithms
import SwiftUI

struct AlgorithmPickerView: View {
    @Binding var algorithm: MazeAlgorithm
    var maskedCellCount: Int
    var onGenerate: () -> Void

    var body: some View {
        HStack {
            Menu(algorithm.rawValue) {
                ForEach(MazeAlgorithm.allCases, id: \.self) { newAlgorithm in
                    Button(newAlgorithm.rawValue) {
                        algorithm = newAlgorithm
                    }
                    .disabled(maskedCellCount > 0 && (newAlgorithm == .sidewinder || newAlgorithm == .binaryTree))
                }
            }

            Button("Generate", action: onGenerate)
        }
    }
}

#Preview {
    AlgorithmPickerView(
        algorithm: .constant(.recursiveBacktracker),
        maskedCellCount: 0,
        onGenerate: { }
    )
}
