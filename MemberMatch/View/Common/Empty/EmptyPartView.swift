//
//  EmptyPartView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/09/17.
//

import SwiftUI

/// 募集パートが選択されていない場合に表示されるアイコン
struct EmptyPartView: View {
    let text: String
    let symbolName: String
    let iconSize: CGFloat

    init(_ text: String, symbolName: String, iconSize: CGFloat) {
        self.text = text
        self.symbolName = symbolName
        self.iconSize = iconSize
    }

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 6)
                .frame(width: iconSize, height: iconSize)
                .foregroundStyle(.white.gradient)
                .shadow(radius: 3)
                .overlay {
                    Image(systemName: symbolName)
                        .font(.title)
                        .foregroundStyle(.gray)
                }
            Text(text)
                .font(.caption)
                .foregroundStyle(Color.gray)
        }
    }
}

#Preview {
    EmptyPartView(Constants.Strings.emptyPart,
                  symbolName: Constants.Symbols.questionmark,
                  iconSize: 300
    )
}
