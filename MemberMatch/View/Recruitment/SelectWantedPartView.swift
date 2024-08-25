//
//  SelectPartView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/22.
//

import SwiftUI

struct SelectWantedPartView: View {
    @Binding var selectionPart: [Part]
    var iconSize: CGFloat { ScreenUtil.deviceWidth / 3 - 10 }

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(Instrument.allCases, id: \.self) { instrument in
                    VStack(spacing: 10) {
                        Image(instrument.iconName(for: Gender.male))
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                            .shadow(radius: 3)
                            .opacity(isSelectionPart(instrument) ? 1 : 0.3)
                            .onTapGesture {
                                if isSelectionPart(instrument) {
                                    withAnimation { selectionPart.removeAll { $0.instrument == instrument } }
                                } else {
                                    withAnimation { selectionPart.append(Part(instrument: instrument)) }
                                }
                            }
                        Text(instrument.text)
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("募集パートの選択")
        }
    }

    private func isSelectionPart(_ instrument: Instrument) -> Bool {
        selectionPart.contains { $0.instrument == instrument }
    }
}

#Preview {
    NavigationStack {
        SelectWantedPartView(selectionPart: .constant([]))
    }
}
