import Testing
@testable import MazeAlgorithms

@Test(arguments: MazeAlgorithm.allCases)
func generatedMazeIsTheCorrectSize(algorithm: MazeAlgorithm) throws {
    let facade = MazeAlgorithmsFacade()
    let maze = try facade.generateMaze(rows: 10, cols: 10, algorithm: algorithm)
    #expect(maze.rows == 10)
    #expect(maze.cols == 10)
}

@Test(arguments: MazeAlgorithm.allCases)
func generatedMazeHasAllCells(algorithm: MazeAlgorithm) throws {
    let facade = MazeAlgorithmsFacade()
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
    let grid = Grid(rows: 4, cols: 4)
    // Manually link cells to create a perfect maze
    if let cell00 = grid[0,0], let cell01 = grid[0,1], let cell02 = grid[0,2], let cell03 = grid[0,3],
       let cell10 = grid[1,0], let cell11 = grid[1,1], let cell12 = grid[1,2], let cell13 = grid[1,3],
       let cell20 = grid[2,0], let cell21 = grid[2,1], let cell22 = grid[2,2], let cell23 = grid[2,3],
       let cell30 = grid[3,0], let cell31 = grid[3,1], let cell32 = grid[3,2], let cell33 = grid[3,3] {
        grid.link(cell1: cell00, cell2: cell01)
        grid.link(cell1: cell00, cell2: cell10)
        grid.link(cell1: cell01, cell2: cell02)
        grid.link(cell1: cell02, cell2: cell03)
        
        grid.link(cell1: cell10, cell2: cell20)
        grid.link(cell1: cell11, cell2: cell12)
        grid.link(cell1: cell11, cell2: cell21)
        grid.link(cell1: cell12, cell2: cell13)
        grid.link(cell1: cell13, cell2: cell23)
        
        grid.link(cell1: cell20, cell2: cell21)
        grid.link(cell1: cell20, cell2: cell30)
        grid.link(cell1: cell22, cell2: cell32)
        
        grid.link(cell1: cell30, cell2: cell31)
        grid.link(cell1: cell31, cell2: cell32)
        grid.link(cell1: cell32, cell2: cell33)
    }
    return grid
}

@Test func testFacadeCalculateWeights() {
    let facade = MazeAlgorithmsFacade()
    let grid = createTestGrid()
    let startPosition = Position(0,0)
    
    let weights = facade.calculateWeights(maze: grid, start: startPosition)
    
    #expect(!weights.isEmpty, "Weights dictionary should not be empty.")
    #expect(weights[Position(0,0)] == 1, "Weight of start cell (0,0) should be 1 (or initial weight).")
    #expect(weights[Position(1,0)] == 2, "Weight of cell (1,0) should be 2.")
    #expect(weights[Position(2,0)] == 3, "Weight of cell (2,0) should be 3.")
    #expect(weights[Position(3,0)] == 4, "Weight of cell (3,0) should be 4.")
    #expect(weights[Position(3,1)] == 5, "Weight of cell (3,1) should be 5.")
}

@Test func testFacadeSolveMaze() {
    let facade = MazeAlgorithmsFacade()
    let grid = createTestGrid()
    let startPosition = Position(0,0)
    let endPosition = Position(3,3)
    
    let path = facade.solveMaze(maze: grid, start: startPosition, end: endPosition)
    
    #expect(!path.isEmpty, "Path should not be empty.")
    let expectedPath = [
        endPosition,
        Position(3,2),
        Position(3,1),
        Position(3,0),
        Position(2,0),
        Position(1,0),
        startPosition
    ]
    #expect(path == expectedPath, "Path did not match expected path. Got: \(path)")
}

@Test func testFacadeLongestPath() {
    let facade = MazeAlgorithmsFacade()
    let grid = createTestGrid()
    let path = facade.longestPath(maze: grid)
    
    #expect(path.count == 11, "Longest path should have 11 positions.")
}
