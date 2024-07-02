//
//  SwiftUIView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/18.
//

import SwiftUI

struct BottomClipShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.9))

        // 右側のなだらかなカーブ
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.95, y: rect.height * 0.85),
                          control: CGPoint(x: rect.width * 0.975, y: rect.height * 0.85))

        // 中央の平面部分
        path.addLine(to: CGPoint(x: rect.width * 0.05, y: rect.height * 0.85))

        // 左側のなだらかなカーブ
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.height * 0.9),
                          control: CGPoint(x: rect.width * 0.025, y: rect.height * 0.85))

        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        return path
    }
}

#Preview {
    BottomClipShape()
}
