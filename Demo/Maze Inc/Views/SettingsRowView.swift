//
//  SettingsRowView.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 13/04/2025.
//

import SwiftUI

struct SettingsRowView: View {
    let title: String
    let selected: Bool

    var body: some View {
        HStack {
            Image(systemName: "gearshift.layout.sixspeed")
                .imageScale(.large)
            Text(title)
                .font(.subheadline)
            Spacer()
        }
        .padding(.leading)
        .foregroundStyle(selected ? .primary: .secondary)
        .frame(width: 216, height: 44)
        .background(selected ? .accent.opacity(0.15) : .clear)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    @Previewable @State var selectedIndex = 0

    VStack {
        ForEach(0..<2) { index in
            Button {
                selectedIndex = index
            } label: {
                SettingsRowView(title: "Name", selected: selectedIndex == index)
                    .contentShape(.rect)
            }
            .buttonStyle(.plain)
        }
    }
}
