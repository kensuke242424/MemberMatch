//
//  HorizontalScrollPartImagesView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2025/01/19.
//

import SwiftUI

struct HorizontalScrollPartImagesView: View {
    let showPart: [Part]
    let iconSize: CGFloat

    let l10n = Constants.Strings.self

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                if showPart.isEmpty {
                    EmptyPartView(l10n.emptyPart,
                                  symbolName: Constants.Symbols.questionmark,
                                  iconSize: iconSize
                    )
                } else {
                    ForEach(showPart) { part in
                        VStack(spacing: 10) {
                            Image(part.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconSize, height: iconSize)
                                .shadow(radius: 3)
                            HStack(spacing: 0) {
                                Text(part.instrument.text)
                                    .font(.caption)
                                    .foregroundStyle(Color.gray)
                                if part.gender != Gender.unknown {
                                    Text("(\(part.gender.text))")
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
            .padding(.horizontal, 5)
        }
    }
}

#Preview {
    HorizontalScrollPartImagesView(showPart: exampleRecruitments.first!.wantedParts, iconSize: 120)
}
