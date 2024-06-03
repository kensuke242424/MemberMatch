//
//  ViewExtension.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI

extension View {
    func clippedToDeviceCorners() -> some View {
        return self.clipShape(RoundedRectangle(cornerRadius: UIScreen.main.deviceCornerRadius, style: .continuous))
    }

    func clippedToDeviceTopCorners() -> some View {
        return self.clipShape(TopCornersRoundedRectangle(cornerRadius: UIScreen.main.deviceCornerRadius))
    }
}

extension View {
    @ViewBuilder
    func offsetRect(completion: @escaping (CGRect) -> Void) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let rect = proxy.frame(in: .global)

                    Color.clear
                        .preference(key: OffsetKey.self, value: rect)
                        .onPreferenceChange(OffsetKey.self, perform: completion)
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
