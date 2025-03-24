//
//  CellView.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 23/03/2025.
//

import SwiftUI

struct CellView: View {
    let walls: [Direction]
    
    var body: some View {
        HStack {
            Text("")
        }
        .background(Color.blue)
        .frame(width: 40, height: 40)
        .overlay {
            CellWalls(walls: walls)
                .stroke(Color.blue, lineWidth: 2)
        }
    }
}

#Preview {
    CellView(walls: [.west, .north])
        .padding()
}
