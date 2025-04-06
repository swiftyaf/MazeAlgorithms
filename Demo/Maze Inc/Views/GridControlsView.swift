//  GridControlsView.swift

import SwiftUI

struct GridControlsView: View {
    @Binding var rows: Double
    @Binding var cols: Double
    @Binding var maskedCells: Double

    var body: some View {
        VStack(spacing: 0) {
            valueSlider(title: "Rows", value: $rows, range: 4...22)
            valueSlider(title: "Columns", value: $cols, range: 4...22)
            valueSlider(title: "Disallowed Cells", value: $maskedCells, range: 0...4)
        }
    }

    @ViewBuilder
    private func valueSlider(title: String, value: Binding<Double>, range: ClosedRange<Double>) -> some View {
        VStack(spacing: 0) {
            Text("\(title): \(Int(value.wrappedValue))")
            HStack {
                Text("\(Int(range.lowerBound))")
                Slider(value: value, in: range, step: 1)
                    .frame(width: 300)
                Text("\(Int(range.upperBound))")
            }
        }
    }
}

#Preview {
    GridControlsView(rows: .constant(10), cols: .constant(10), maskedCells: .constant(0))
}
