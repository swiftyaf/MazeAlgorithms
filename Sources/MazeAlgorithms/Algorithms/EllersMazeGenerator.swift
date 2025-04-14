//
//  EllersMazeGenerator.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 02/04/2025.
//

public class EllersMazeGenerator: MazeGenerating {
    class RowState {
        private var setForCell: [Position: Int] = [:]
        private var cellsInSet: [Int: [Position]] = [:]
        private var currentSetId: Int
        init(startingSetId: Int = 0) {
            self.currentSetId = startingSetId
        }
        
        func recordCell(_ position: Position, inSetWithId setId: Int) {
            setForCell[position] = setId
            cellsInSet[setId, default: []].append(position)
        }
        
        func setFor(_ position: Position) -> Int {
            if setForCell[position] == nil {
                recordCell(position, inSetWithId: currentSetId)
                currentSetId += 1
            }
            return setForCell[position]!
        }
        
        func mergeSets(_ setId1: Int, _ setId2: Int) {
            for cell in cellsInSet[setId2]! {
                setForCell[cell] = setId1
            }
            let set2 = cellsInSet[setId2]!
            cellsInSet[setId1]?.append(contentsOf: set2)
        }
        
        func next() -> RowState {
            RowState(startingSetId: currentSetId)
        }
        
        func eachSet(_ operation: (Int, [Position]) -> Void) {
            for (setId, cells) in cellsInSet {
                operation(setId, cells)
            }
        }
    }
    
    var grid: Grid
    var generating = false
    var rowState = RowState()
    var currentRow = 0
    var currentCol = 0

    public init(grid: Grid = Grid(rows: 10, cols: 10)) {
        self.grid = grid
    }
    
    public func setGrid(_ grid: Grid) {
        self.grid = grid
        generating = false
    }

    public func generateNextStep() -> Bool {
        if !generating {
            generating = true
            currentRow = 0
            currentCol = 0
            var rowState = RowState()
        }
        
        let position = Position(currentRow, currentCol)
        if let cell = grid[position] {
            if let westCell = grid.cell(nextTo: cell, direction: .west) {
                let setId = rowState.setFor(cell.position)
                let priorSetId = rowState.setFor(westCell.position)
                let shouldLink = setId != priorSetId &&
                (grid.cell(nextTo: cell, direction: .south) == nil || Int.random(in: 0..<2) == 0)
                if shouldLink {
                    grid.link(cell1: cell, cell2: westCell)
                    rowState.mergeSets(priorSetId, setId)
                }
            }
        }

        currentCol += 1
        if currentCol == grid.cols {
            if currentRow < grid.rows - 1 {
                let nextRow = rowState.next()
                rowState.eachSet { setId, list in
                    let shuffledList = list.shuffled()
                    for i in 0..<shuffledList.count {
                        let position = shuffledList[i]
                        let cell = grid[position]!
                        if i == 0 || Int.random(in: 0..<3) == 0 {
                            if let southCell = grid.cell(nextTo: cell, direction: .south) {
                                grid.link(cell1: cell, cell2: southCell)
                                nextRow.recordCell(southCell.position, inSetWithId: rowState.setFor(cell.position))
                            }
                        }
                    }
                }
                rowState = nextRow
            }
            
            currentRow += 1
            currentCol = 0
            if currentRow == grid.rows {
                generating = false
                return false
            }
        }
        return true
    }
            
    public func generateMaze(in grid: Grid) {
        self.grid = grid
        while generateNextStep() {}
    }
}
