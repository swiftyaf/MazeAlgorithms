import Testing
@testable import MazeAlgorithms // Ensures internal types are accessible if needed, public for facade
import Foundation // For XCTAssert if not using #expect fully, but #expect is preferred

// --- Existing Tests (Potentially update to Facade if time/scope permits, but focusing on new tests first) ---
@Test(arguments: MazeAlgorithm.allCases)
func generatedMazeIsTheCorrectSize(algorithm: MazeAlgorithm) throws {
    let facade = MazeAlgorithmsFacade() // Using Facade
    let maze = try facade.generateMaze(rows: 10, cols: 10, algorithm: algorithm)
    #expect(maze.rows == 10)
    #expect(maze.cols == 10)
}

@Test(arguments: MazeAlgorithm.allCases)
func generatedMazeHasAllCells(algorithm: MazeAlgorithm) throws {
    let facade = MazeAlgorithmsFacade() // Using Facade
    let maze = try facade.generateMaze(rows: 10, cols: 10, algorithm: algorithm)
    #expect(maze.totalCells == maze.intersectionCells + maze.deadendCells + maze.passageCells)
}

@Test(arguments: MazeAlgorithm.allCases)
func twistedPlusThroughEqualPassageCells(algorithm: MazeAlgorithm) throws {
    let facade = MazeAlgorithmsFacade() // Using Facade
    let maze = try facade.generateMaze(rows: 10, cols: 10, algorithm: algorithm)
    #expect(maze.passageCells == maze.twistedCells + maze.throughCells)
}

// --- Helper for creating a predictable test maze ---
func createTestGrid() -> Grid {
    let grid = Grid(rows: 3, cols: 3)
    // Manually link cells to create a known path
    // Path: (0,0) -> (0,1) -> (0,2) -> (1,2) -> (2,2)
    // Links are bidirectional
    if let cell00 = grid[0,0], let cell01 = grid[0,1],
       let cell02 = grid[0,2], let cell12 = grid[1,2],
       let cell22 = grid[2,2] {
        
        cell00.link(to: cell01) // (0,0) <-> (0,1)
        cell01.link(to: cell02) // (0,1) <-> (0,2)
        cell02.link(to: cell12) // (0,2) <-> (1,2)
        cell12.link(to: cell22) // (1,2) <-> (2,2)
    }
    return grid
}

// --- New Tests for MazeAlgorithmsFacade ---

@Test func testFacadeCalculateWeights() {
    let facade = MazeAlgorithmsFacade()
    let grid = createTestGrid()
    let startPosition = Position(0,0)
    
    let weights = facade.calculateWeights(maze: grid, start: startPosition)
    
    #expect(!weights.isEmpty, "Weights dictionary should not be empty.")
    #expect(weights[Position(0,0)] == 1, "Weight of start cell (0,0) should be 1 (or initial weight).")
    #expect(weights[Position(0,1)] == 2, "Weight of cell (0,1) should be 2.")
    #expect(weights[Position(0,2)] == 3, "Weight of cell (0,2) should be 3.")
    #expect(weights[Position(1,2)] == 4, "Weight of cell (1,2) should be 4.")
    #expect(weights[Position(2,2)] == 5, "Weight of cell (2,2) should be 5.")
    
    // Test a cell not on the direct path but reachable if structure was more complex
    // For current simple path, unlinked cells won't be in weights.
    #expect(weights[Position(1,0)] == nil, "Weight of unlinked cell (1,0) should be nil.")
}

@Test func testFacadeSolveMaze() {
    let facade = MazeAlgorithmsFacade()
    let grid = createTestGrid()
    let startPosition = Position(0,0)
    let endPosition = Position(2,2)
    
    let path = facade.solveMaze(maze: grid, start: startPosition, end: endPosition)
    
    #expect(!path.isEmpty, "Path should not be empty.")
    // MazeSolver returns path from end to start, so reversed for start to end.
    // Or, if it's already start to end, this check needs adjustment.
    // Based on previous MazeManager usage: path = mazeSolver.solveMaze(...).reversed()
    // So, facade.solveMaze should return it in a way that matches this (start to end, or needs reversal by client).
    // Assuming solveMaze returns path from END to START as per typical Dijkstra breadcrumb traversal.
    
    let expectedPath = [endPosition, Position(1,2), Position(0,2), Position(0,1), startPosition] // Path from end to start
    #expect(path == expectedPath, "Path did not match expected path. Got: \(path)")

    // If the facade is expected to return path from start to end:
    // let expectedReversedPath = [startPosition, Position(0,1), Position(0,2), Position(1,2), endPosition]
    // #expect(path == expectedReversedPath, "Path did not match expected (start to end) path. Got: \(path)")

}

@Test func testFacadeLongestPath() {
    let facade = MazeAlgorithmsFacade()
    let grid = createTestGrid() // Using the same simple grid
    
    // For our specific simple grid, the longest path is the one we defined:
    // (0,0) <-> (0,1) <-> (0,2) <-> (1,2) <-> (2,2), length 5 cells.
    let path = facade.longestPath(maze: grid)
    
    #expect(!path.isEmpty, "Longest path should not be empty.")
    #expect(path.count >= 2, "Longest path should have at least 2 cells (start and end).")

    // The current `longestPath` implementation in `MazeSolver` does two `calculateWeights`
    // calls to find the most distant pair. For our simple linear path, it should find it.
    // The path returned by `longestPath` is from its determined start to its determined end.
    
    // Possible longest paths in the simple grid (could be one of two directions):
    let path1 = [Position(0,0), Position(0,1), Position(0,2), Position(1,2), Position(2,2)]
    let path2 = [Position(2,2), Position(1,2), Position(0,2), Position(0,1), Position(0,0)]

    let pathIsValid = (path == path1 || path == path2)
    #expect(pathIsValid, "Longest path did not match one of the expected paths. Got: \(path)")
    #expect(path.count == 5, "Longest path for this specific grid should be 5 cells long.")
}

// It's good practice to test edge cases, like an empty grid or a grid with no paths,
// but these tests cover the basic functionality.
// For example:
// @Test func testSolveMazeNoPath() { ... }
// @Test func testCalculateWeightsUnreachable() { ... }
