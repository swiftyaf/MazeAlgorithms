//  MazeGeneratorError.swift

import Foundation

/// Errors thrown during maze generation setup.
public enum MazeGeneratorError: Error, LocalizedError {
    /// The selected algorithm does not support masked cells.
    case maskedCellsNotSupported(algorithm: MazeAlgorithm)

    public var errorDescription: String? {
        switch self {
        case .maskedCellsNotSupported(let algorithm):
            return "\(algorithm.rawValue) does not support masked cells."
        }
    }
}
