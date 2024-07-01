//
//  CapsuleView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/06/17.
//

import SwiftUI

struct CapsuleView: View {
    var texts: [String]
    var highlightedTexts: [String] // 色をオレンジにするテキストのリスト

    @State private var totalHeight: CGFloat = .zero

    var body: some View {
        FlexibleCapsuleView(texts: texts, highlightedTexts: highlightedTexts, totalHeight: $totalHeight)
            .frame(height: totalHeight)
    }
}

struct FlexibleCapsuleView: View {
    var texts: [String]
    var highlightedTexts: [String]
    @Binding var totalHeight: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            generateRows(for: texts)
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                self.totalHeight = geometry.size.height
                            }
                    }
                )
        }
    }

    private func generateRows(for texts: [String]) -> some View {
        var currentRow: [String] = []
        var currentWidth: CGFloat = 0
        var rows: [[String]] = []

        for text in texts {
            let textWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width + 20
            if currentWidth + textWidth + 10 > UIScreen.main.bounds.width - 30 { // パディングを考慮
                // Current row is full, create a new row
                rows.append(currentRow)
                currentRow = [text]
                currentWidth = textWidth
            } else {
                // Add to current row
                currentRow.append(text)
                currentWidth += textWidth + 10
            }
        }

        // Add the last row
        if !currentRow.isEmpty {
            rows.append(currentRow)
        }

        return VStack(alignment: .leading) {
            ForEach(rows, id: \.self) { row in
                RowView(texts: row, highlightedTexts: highlightedTexts)
            }
        }
    }
}

struct RowView: View {
    var texts: [String]
    var highlightedTexts: [String]

    var body: some View {
        HStack {
            ForEach(texts, id: \.self) { text in
                Text(text)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(isHighlighted(text) ? Color.customAccentYellow : Color.gray))
                    .foregroundStyle(.white)
                    .opacity(isHighlighted(text) ? 1 : 0.6)
                    .fixedSize() // テキストの省略を防ぐ
            }
        }
    }

    private func isHighlighted(_ text: String) -> Bool {
        highlightedTexts.contains(text)
    }
}

#Preview {
    VStack {
        Rectangle().frame(width: 300, height: 300)
        CapsuleView(
            texts: Constants.musicGenreTexts,
            highlightedTexts: ["ロック", "ジャズ", "ブルース"]
        )
        Rectangle().frame(width: 300, height: 300)
    }
}
