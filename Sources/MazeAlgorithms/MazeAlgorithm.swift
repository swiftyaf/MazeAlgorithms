//
//  MazeAlgorithm.swift
//  MazeAlgorithms
//
//  Created by Dimi Chakarov on 08/11/2025.
//

import Foundation

public enum MazeAlgorithm: String, CaseIterable, Sendable, Identifiable {
    public var id: String {
        self.rawValue
    }
    
    case binaryTree = "Binary Tree"
    case sidewinder = "Sidewinder"
    case aldousBroder = "Aldous-Broder"
    case wilson = "Wilson"
    case hunterKiller = "Hunt and Kill"
    case recursiveBacktracker = "Recursive Backtracker"
    case kruskal = "Randomised Kruskal's"
    case simplifiedPrim = "Simplified Prim"
    case modifiedPrim = "Modified Prim"
    case prim = "Prim"
    case growingTree = "Growing Tree"
    case ellers = "Eller's"
    case recursiveDivision = "Recursive Division"

    public var generator: MazeGenerating {
        switch self {
        case .binaryTree: BinaryTreeMazeGenerator()
        case .sidewinder: SidewinderMazeGenerator()
        case .aldousBroder: AldousBroderMazeGenerator()
        case .wilson: WilsonMazeGenerator()
        case .hunterKiller: HunterKillerMazeGenerator()
        case .recursiveBacktracker: RecursiveBacktrackerMazeGenerator()
        case .kruskal: KruskalsMazeGenerator()
        case .simplifiedPrim: SimplifiedPrimMazeGenerator()
        case .prim: PrimMazeGenerator()
        case .growingTree: GrowingTreeMazeGenerator()
        case .modifiedPrim: ModifiedPrimMazeGenerator()
        case .ellers: EllersMazeGenerator()
        case .recursiveDivision: RecursiveDivisionMazeGenerator()
        }
    }
}
