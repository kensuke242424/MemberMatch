//
//  GradientBackgroundModifier.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI

struct GradientBackgroundModifier: ViewModifier {
    var startColor: Color?
    var endColor: Color?

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(
                gradient: Gradient(colors: [
                    startColor ?? .customMediumGray,
                    endColor ?? .customDarkGray
                ]),
                startPoint: .top,
                endPoint: .bottom
            ))
    }
}

extension View {
    func gradientBackground(_ startColor: Color? = nil, _ endColor: Color? = nil) -> some View {
        self.modifier(GradientBackgroundModifier(startColor: startColor, endColor: endColor))
    }
}
