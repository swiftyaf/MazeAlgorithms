//  GridControlsView.swift

import SwiftUI

struct GridControlsView: View {
    @Binding var rows: Double
    @Binding var cols: Double

    var body: some View {
        VStack(spacing: 0) {
            valueSlider(title: "Rows", value: $rows, range: 4...22)
            valueSlider(title: "Columns", value: $cols, range: 4...22)
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
    @Previewable @State var rows = 10.0
    @Previewable @State var cols = 10.0

    GridControlsView(rows: $rows, cols: $cols)
}
