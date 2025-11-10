//
//  SettingsView.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 13/04/2025.
//

import SwiftUI
import MazeAlgorithms

struct SettingsView: View {
    @Binding var isShowing: Bool
    @Binding var selectedAlgorithm: MazeAlgorithm
    
    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isShowing.toggle()
                    }
                
                HStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Algorithm")
                        
                        ForEach(MazeAlgorithm.allCases) { algorithm in
                            Button {
                                selectedAlgorithm = algorithm
                                isShowing = false
                            } label: {
                                SettingsRowView(
                                    title: algorithm.rawValue,
                                    selected: selectedAlgorithm == algorithm
                                )
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(in: .rect(cornerRadius: 10))
                    .padding(.vertical)
                }
                .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    @Previewable @State var isShowing = true
    @Previewable @State var selectedAlgorithm: MazeAlgorithm = .binaryTree

    SettingsView(
        isShowing: $isShowing,
        selectedAlgorithm: $selectedAlgorithm
    )

    // Reopen the menu for easier testing.
    .onChange(of: selectedAlgorithm) {
        isShowing = true
    }
}
