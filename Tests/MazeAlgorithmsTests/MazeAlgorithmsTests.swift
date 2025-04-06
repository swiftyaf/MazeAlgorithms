import Testing
@testable import MazeAlgorithms

@Test(arguments: MazeAlgorithm.allCases)
func generatedMazeIsTheCorrectSize(algorithm: MazeAlgorithm) throws {
    let mazeGenerator = MazeGenerator()
    let maze = try mazeGenerator.generateMaze(rows: 10, cols: 10, algorithm: algorithm)
    #expect(maze.rows == 10)
    #expect(maze.cols == 10)
}

@Test(arguments: MazeAlgorithm.allCases)
func generatedMazeHasAllCells(algorithm: MazeAlgorithm) throws {
    let mazeGenerator = MazeGenerator()
    let maze = try mazeGenerator.generateMaze(rows: 10, cols: 10, algorithm: algorithm)
    
    #expect(maze.totalCells == maze.intersectionCells + maze.deadendCells + maze.passageCells)
}

@Test(arguments: MazeAlgorithm.allCases)
func twistedPlusThroughEqualPassageCells(algorithm: MazeAlgorithm) throws {
    let mazeGenerator = MazeGenerator()
    let maze = try mazeGenerator.generateMaze(rows: 10, cols: 10, algorithm: algorithm)
    
    #expect(maze.passageCells == maze.twistedCells + maze.throughCells)
}
