//
//  SeededRandomNumberGenerator.swift
//  MazeAlgorithms
//

/// A deterministic random number generator (SplitMix64).
///
/// The same seed always produces the same sequence on every platform and Swift version,
/// which makes it suitable for mazes that must be reproducible, e.g. a daily maze shared by
/// all players.
///
/// Use `nextInt(upperBound:)` and `element(of:)` rather than the standard library's
/// `Int.random(in:using:)` / `randomElement(using:)`: those are free to change how they
/// consume random bits between Swift releases, while these are fixed.
public struct SeededRandomNumberGenerator: RandomNumberGenerator, Sendable {
    private var state: UInt64

    public init(seed: UInt64) {
        self.state = seed
    }

    public mutating func next() -> UInt64 {
        state &+= 0x9E37_79B9_7F4A_7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58_476D_1CE4_E5B9
        z = (z ^ (z >> 27)) &* 0x94D0_49BB_1331_11EB
        return z ^ (z >> 31)
    }

    /// Returns a uniformly distributed integer in `0..<upperBound`.
    ///
    /// - Precondition: `upperBound > 0`
    public mutating func nextInt(upperBound: Int) -> Int {
        precondition(upperBound > 0, "upperBound must be positive")
        let bound = UInt64(upperBound)
        // Reject the top partial range so every value is equally likely
        let limit = UInt64.max - UInt64.max % bound
        var value = next()
        while value >= limit {
            value = next()
        }
        return Int(value % bound)
    }

    /// Returns a uniformly chosen element of `array`, or `nil` if it is empty.
    public mutating func element<T>(of array: [T]) -> T? {
        guard !array.isEmpty else { return nil }
        return array[nextInt(upperBound: array.count)]
    }
}
