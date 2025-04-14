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
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Algorithm")
                        
                        ForEach(MazeAlgorithm.allCases) { algorithm in
                            Button {
                                selectedAlgorithm = algorithm
                                isShowing = false
                            } label: {
                                SettingsRowView(
                                    title: algorithm.rawValue,
                                    selected: Binding<Bool>(
                                        get: { selectedAlgorithm == algorithm },
                                        set: { _ in }
                                    )
                                )
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical)
                }
                .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    SettingsView(isShowing: .constant(true), selectedAlgorithm: .constant(.binaryTree))
}
