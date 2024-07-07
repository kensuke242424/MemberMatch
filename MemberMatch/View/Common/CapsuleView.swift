//
//  CapsuleView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/06/17.
//

import SwiftUI

struct MusicGenresCapsuleView: View {
    let genres: [MusicGenre]
    @Binding var highlightedGenres: [MusicGenre] // 色をオレンジにするジャンルのリスト
    let isEditing: Bool

    @State private var totalHeight: CGFloat = .zero

    var body: some View {
        FlexibleCapsuleView(genres: genres,
                            highlightedGenres: $highlightedGenres,
                            totalHeight: $totalHeight,
                            isEditing: isEditing
        )
        .frame(height: totalHeight)
    }
}

struct FlexibleCapsuleView: View {
    var genres: [MusicGenre]
    @Binding var highlightedGenres: [MusicGenre]
    @Binding var totalHeight: CGFloat
    let isEditing: Bool

    var body: some View {
        VStack(alignment: .leading) {
            generateRows(for: genres)
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

    private func generateRows(for genres: [MusicGenre]) -> some View {
        var currentRow: [MusicGenre] = []
        var currentWidth: CGFloat = 0
        var rows: [[MusicGenre]] = []

        for genre in genres {
            let textWidth = genre.text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width + 20
            if currentWidth + textWidth + 10 > UIScreen.main.bounds.width - 30 { // パディングを考慮
                // Current row is full, create a new row
                rows.append(currentRow)
                currentRow = [genre]
                currentWidth = textWidth
            } else {
                // Add to current row
                currentRow.append(genre)
                currentWidth += textWidth + 10
            }
        }

        // Add the last row
        if !currentRow.isEmpty {
            rows.append(currentRow)
        }

        return VStack(alignment: .leading) {
            ForEach(rows, id: \.self) { row in
                RowView(genres: row, highlightedGenres: $highlightedGenres, isEditing: isEditing)
            }
        }
    }
}

struct RowView: View {
    let genres: [MusicGenre]
    @Binding var highlightedGenres: [MusicGenre]
    let isEditing: Bool

    var body: some View {
        HStack {
            ForEach(genres, id: \.self) { genre in
                Text(genre.text)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(isHighlighted(genre) ? Color.customAccentYellow : Color.gray))
                    .foregroundStyle(.white)
                    .opacity(isHighlighted(genre) ? 1 : 0.6)
                    .fixedSize() // テキストの省略を防ぐ
                    .onTapGesture {
                        if !isEditing { return }

                        if isHighlighted(genre) {
                            withAnimation(.spring) {
                                highlightedGenres.removeAll { $0 == genre }
                            }

                        } else {
                            withAnimation(.spring) {
                                highlightedGenres.append(genre)
                            }
                        }
                    }
            }
        }
    }

    private func isHighlighted(_ genre: MusicGenre) -> Bool {
        highlightedGenres.contains(genre)
    }
}

#Preview {
    VStack {
        Rectangle().frame(width: 300, height: 300)
        MusicGenresCapsuleView(
            genres: MusicGenre.allCases,
            highlightedGenres: .constant([.rock, .jazz, .blues]),
            isEditing: true
        )
        Rectangle().frame(width: 300, height: 300)
    }
}
