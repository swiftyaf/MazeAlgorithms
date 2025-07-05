//
//  Grid.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

@Observable
public class Grid { // NW = 0,0
    let cells: [[Cell]]
    private var maskedCells: [Position]
    private(set) var cellWeights: [Position: Int]
    public let rows: Int
    public let cols: Int
    
    public var totalCells: Int {
        rows * cols - maskedCells.count
    }
    
    public var allCells: [Cell] {
        cells.flatMap { $0 }.filter { !maskedCells.contains($0.position) }
    }
    
    public init(rows: Int, cols: Int, maskedCells: [Position] = [], weights: [Position: Int] = [:]) {
        var cellWeights: [Position: Int] = [:]
        self.rows = rows
        self.cols = cols
        var cells = [[Cell]]()
        for row in 0..<rows {
            var rowCells: [Cell] = []
            for col in 0..<cols {
                let position = Position(row, col)
                rowCells.append(Cell(position: position))
                cellWeights[position] = weights[position] ?? 1
            }
            cells.append(rowCells)
        }
        self.cells = cells
        self.maskedCells = maskedCells
        self.cellWeights = cellWeights
    }
    
    public subscript(position: Position) -> Cell? {
        self[position.row, position.col]
    }
    
    public subscript(row: Int, col: Int) -> Cell? {
        guard row >= 0, row < rows, col >= 0, col < cols else {
            return nil
        }
        guard !maskedCells.contains(where: { $0.row == row && $0.col == col }) else {
            return nil
        }
        return cells[row][col]
    }
    
    public func updateWeights(_ weights: [Position: Int]) {
        cellWeights = weights
    }
    
    public func randomCell() -> Cell {
        let randomRow = Int.random(in: 0..<rows)
        let randomCol = Int.random(in: 0..<cols)
        return self[randomRow, randomCol] ?? randomCell()
    }
    
    public func cell(nextTo cell: Cell, direction: Direction) -> Cell? {
        let nextCellPosition = Position(cell.position.row + direction.offset.vertical,
                                        cell.position.col + direction.offset.horizontal)
        return self[nextCellPosition]
    }
    
    public func neighbours(of cell: Cell) -> [Cell] {
        var neighbours: [Cell] = []
        for direction in Direction.allCases {
            if let neighbour = self.cell(nextTo: cell, direction: direction) {
                neighbours.append(neighbour)
            }
        }
        return neighbours
    }
    
    public func link(cell1: Cell, cell2: Cell) {
        cell1.link(to: cell2)
        cell2.link(to: cell1)
    }
    
    public func unlink(cell1: Cell, cell2: Cell) {
        cell1.links = cell1.links.filter { $0 !== cell2 }
        cell2.links = cell2.links.filter { $0 !== cell1 }
    }
    
    public func wallExists(currentCell: Cell, direction: Direction) -> Bool {
        guard let neighbour = cell(nextTo: currentCell, direction: direction) else {
            return true
        }
        
        return !currentCell.links.contains(where: { $0 === neighbour })
    }
    
    public func walls(of cell: Cell) -> [Direction] {
        var directions: [Direction] = []
        if wallExists(currentCell: cell, direction: .north) {
            directions.append(.north)
        }
        if wallExists(currentCell: cell, direction: .east) {
            directions.append(.east)
        }
        if wallExists(currentCell: cell, direction: .south) {
            directions.append(.south)
        }
        if wallExists(currentCell: cell, direction: .west) {
            directions.append(.west)
        }
        return directions
    }
    
    public func braid(p: Int = 10) {
        let deadends = deadendCells.shuffled()
        deadends.forEach { deadend in
            if deadend.links.count == 1 && Int.random(in: 0..<10) < p {
                let neighbours = neighbours(of: deadend)
                    .filter { !$0.links.contains(where: { $0 === deadend }) }
                if neighbours.isEmpty { return }
                let bestNeighbours: [Cell]
                let deadendNeighbours = neighbours.filter { $0.links.count == 1 }
                bestNeighbours = deadendNeighbours.isEmpty ? neighbours : deadendNeighbours
                let randomNeighbour = bestNeighbours.randomElement()!
                link(cell1: deadend, cell2: randomNeighbour)
            }
        }
    }
    
    public func cull(ignoring: [Position] = []) {
        let deadends = deadendCells.filter { !ignoring.contains($0.position) }.shuffled()
        var culledCellCount = 0
        deadends.forEach { deadend in
            deadend.links.forEach { link in
                unlink(cell1: deadend, cell2: link)
            }
            maskedCells.append(deadend.position)
            culledCellCount += 1
        }
        if culledCellCount > 0 {
            cull(ignoring: ignoring)
        }
    }
    
    public func mask(cells: [Position]) {
        maskedCells.append(contentsOf: cells)
    }
    
    public func unmask(cells: [Position]) {
        maskedCells.removeAll { cells.contains($0) }
    }
    
    // MARK: Stats
        
    public var isolatedCells: [Cell] {
        allCells.filter { $0.links.isEmpty }
    }
    
    public var isolatedCellCount: Int {
        isolatedCells.count
    }
    
    public var deadendCells: [Cell] {
        allCells.filter { $0.links.count == 1 }
    }
    
    public var deadendCellCount: Int {
        deadendCells.count
    }
    
    public var twistedCells: Int {
        allCells
            .filter { $0.links.count == 2 }
            .filter {
                ($0.passages[.east]! && $0.passages[.south]!) ||
                ($0.passages[.south]! && $0.passages[.west]!) ||
                ($0.passages[.west]! && $0.passages[.north]!) ||
                ($0.passages[.north]! && $0.passages[.east]!)
            }
            .count
    }
    
    public var throughCells: [Cell] {
        allCells
            .filter { $0.links.count == 2 }
            .filter {
                ($0.passages[.east]! && $0.passages[.west]!) ||
                ($0.passages[.south]! && $0.passages[.north]!)
            }
    }
    
    public var throughCellCount: Int {
        throughCells.count
    }
    
    public var passageCells: [Cell] {
        allCells
            .filter { $0.links.count == 2 }
    }
    
    public var passageCellCount: Int {
        passageCells.count
    }
    
    public var intersectionCells: [Cell] {
        allCells
            .filter { $0.links.count >= 3 }
    }
    
    public var intersectionCellCount: Int {
        intersectionCells.count
    }
}
