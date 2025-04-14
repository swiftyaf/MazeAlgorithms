//
//  SettingsRowView.swift
//  Maze Inc
//
//  Created by Dimi Chakarov on 13/04/2025.
//

import SwiftUI

struct SettingsRowView: View {
    let title: String
    @Binding var selected: Bool
    
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
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SettingsRowView(title: "Name", selected: .constant(true))
}
