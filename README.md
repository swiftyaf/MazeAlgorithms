# MazeAlgorithms

A Swift framework for generating perfect mazes using classic algorithms.

## Overview

**MazeAlgorithms** is a lightweight Swift framework that implements popular maze generation algorithms, inspired by [*Mazes for Programmers*](https://pragprog.com/titles/jbmaze/mazes-for-programmers/) by Jamis Buck.

Generate beautiful, procedural mazes using multiple algorithms—each with unique characteristics. Perfect for games, puzzles, visualizations, or learning about graph algorithms.

## Features

- **Multiple Algorithms**: Recursive Backtracker, Prim's Algorithm, Binary Tree, and more
- **Observable State**: Built with SwiftUI in mind—cells and grids are `@Observable` for reactive visualization
- **Protocol-Oriented Design**: Swap algorithms easily via the `MazeGenerating` protocol
- **Step-by-Step Generation**: Generate mazes one step at a time for real-time visualization
- **Solvers Included**: Includes maze solver for finding optimal paths (Dijkstra's algorithm)

## Getting Started

### Installation

Add this to your `Package.swift`:

```swift
.package(url: "https://github.com/swiftyaf/MazeAlgorithms.git", branch: "main")
```

Or in Xcode: File → Add Packages → Enter the repository URL.

### Basic Usage

Here's how to generate and visualize a maze:

```swift
import MazeAlgorithms

// Create a grid
let grid = Grid(rows: 20, cols: 20)

// Initialise the framework facade
let mazeFacade = MazeAlgorithmsFacade()

// Choose an algorithm
let algorithm = RecursiveBacktrackerMazeGenerator()

// Generate the maze
mazeFacade.generateMaze(in: grid, algorithm: algorithm)

// Access the maze
let maze = grid
```

### Step-by-Step Visualization

For real-time visualization in SwiftUI, use `generateStep()`. Check the demo app for full example.

### Solving Mazes

Find the optimal path between two cells:

```swift
let solver = MazeSolver()
let path = solver.solve(maze: grid, from: startCell, to: goalCell)
```

## Available Algorithms

- **Recursive Backtracker**: Long corridors, high complexity—perfect for challenging mazes
- **Prim's Algorithm**: Organic, tree-like structure with many branching paths
- **Binary Tree**: Fast generation with predictable diagonal patterns
- **And more**: See the [MazeAlgorithm enum](Sources/MazeAlgorithms/MazeAlgorithm.swift) for all available algorithms

## Learning Resources

This framework is based on the excellent book:

[**Mazes for Programmers**](https://pragprog.com/titles/jbmaze/mazes-for-programmers/) by Jamis Buck  
Learn how to write algorithms that generate perfect mazes and explore their properties. Highly recommended!

## Contributing

Contributions are welcome! Whether you're adding new algorithms, improving performance, fixing bugs, or enhancing documentation, I'd love your help.

Please feel free to:
- Open issues for bugs or feature requests
- Submit pull requests with improvements
- Share ideas for new maze algorithms

## License

The Unlicense. See LICENSE for details.

---

**Built by**: Dimi Chakarov
