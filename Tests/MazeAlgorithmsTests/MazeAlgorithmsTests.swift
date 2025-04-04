import Testing
@testable import MazeAlgorithms

@Test(arguments: MazeAlgorithm.allCases) func generatedMazeIsTheCorrectSize(algorithm: MazeAlgorithm) {
    let mazeGenerator = MazeGenerator()
    let maze = mazeGenerator.generateMaze(rows: 10, cols: 10, algorithm: algorithm)
    #expect(maze.rows == 10)
    #expect(maze.cols == 10)
}
