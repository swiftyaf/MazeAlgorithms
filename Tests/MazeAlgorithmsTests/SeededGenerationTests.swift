import Testing
@testable import MazeAlgorithms

/// Encodes a maze's passages as one character per cell (bit 0 = open east, bit 1 = open south),
/// row by row, so two mazes can be compared and a known maze can be pinned.
func fingerprint(_ grid: Grid) -> String {
    var result = ""
    for row in 0..<grid.rows {
        for col in 0..<grid.cols {
            guard let cell = grid[row, col] else {
                result += "x"
                continue
            }
            var value = 0
            if !grid.wallExists(currentCell: cell, direction: .east) { value |= 1 }
            if !grid.wallExists(currentCell: cell, direction: .south) { value |= 2 }
            result += String(value)
        }
    }
    return result
}

@Test func splitMixMatchesReferenceOutput() {
    // First outputs of the reference SplitMix64 implementation for seed 0
    var generator = SeededRandomNumberGenerator(seed: 0)
    #expect(generator.next() == 0xE220_A839_7B1D_CDAF)
    #expect(generator.next() == 0x6E78_9E6A_A1B9_65F4)
    #expect(generator.next() == 0x06C4_5D18_8009_454F)
}

@Test func nextIntStaysInRange() {
    var generator = SeededRandomNumberGenerator(seed: 42)
    for upperBound in [1, 2, 3, 7, 100] {
        for _ in 0..<200 {
            let value = generator.nextInt(upperBound: upperBound)
            #expect(value >= 0 && value < upperBound)
        }
    }
}

@Test func elementOfEmptyArrayIsNil() {
    var generator = SeededRandomNumberGenerator(seed: 1)
    let empty: [Int] = []
    #expect(generator.element(of: empty) == nil)
}

@Test(arguments: [UInt64(0), 1, 20_261_017, .max])
func sameSeedProducesSameMaze(seed: UInt64) throws {
    let facade = MazeAlgorithmsFacade()
    let first = Grid(rows: 12, cols: 8)
    let second = Grid(rows: 12, cols: 8)
    try facade.generateMaze(in: first, algorithm: .recursiveBacktracker, seed: seed)
    try facade.generateMaze(in: second, algorithm: .recursiveBacktracker, seed: seed)
    #expect(fingerprint(first) == fingerprint(second))
}

@Test func reusedGeneratorRepeatsTheSameMaze() {
    let generator = RecursiveBacktrackerMazeGenerator(seed: 7)
    let first = Grid(rows: 9, cols: 6)
    let second = Grid(rows: 9, cols: 6)
    generator.generateMaze(in: first)
    generator.generateMaze(in: second)
    #expect(fingerprint(first) == fingerprint(second))
}

@Test func differentSeedsProduceDifferentMazes() throws {
    let facade = MazeAlgorithmsFacade()
    let fingerprints = try (0..<10).map { seed in
        let grid = Grid(rows: 12, cols: 8)
        try facade.generateMaze(in: grid, algorithm: .recursiveBacktracker, seed: UInt64(seed))
        return fingerprint(grid)
    }
    #expect(Set(fingerprints).count == fingerprints.count)
}

@Test func seededMazeIsPerfect() throws {
    let facade = MazeAlgorithmsFacade()
    let grid = Grid(rows: 15, cols: 10)
    try facade.generateMaze(in: grid, algorithm: .recursiveBacktracker, seed: 99)
    // A perfect maze is a spanning tree: every cell reachable, links = cells - 1
    let linkCount = grid.allCells.reduce(0) { $0 + $1.links.count } / 2
    #expect(linkCount == grid.totalCells - 1)
    #expect(grid.isolatedCellCount == 0)
}

/// Pins the exact maze for a known seed. If this fails, seeded mazes have changed and every
/// app relying on reproducible mazes (e.g. a daily maze) would show players different mazes.
@Test func seededMazeIsStableAcrossVersions() throws {
    let facade = MazeAlgorithmsFacade()
    let grid = Grid(rows: 6, cols: 4)
    try facade.generateMaze(in: grid, algorithm: .recursiveBacktracker, seed: 2026)
    #expect(fingerprint(grid) == "311222302102233020121110")
}

@Test(arguments: MazeAlgorithm.allCases)
func unsupportedAlgorithmsThrowForSeeds(algorithm: MazeAlgorithm) {
    let facade = MazeAlgorithmsFacade()
    let grid = Grid(rows: 4, cols: 4)
    if algorithm.supportsSeeding {
        #expect(throws: Never.self) { try facade.generateMaze(in: grid, algorithm: algorithm, seed: 1) }
    } else {
        #expect(throws: MazeGeneratorError.self) { try facade.generateMaze(in: grid, algorithm: algorithm, seed: 1) }
    }
}
