//
//  TopCornersRoundedRectangle.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/18.
//

import SwiftUI

struct TopCornersRoundedRectangle: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // 左上の角から右上の角に向かって直線を引く
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}

#Preview {
    TopCornersRoundedRectangle(cornerRadius: 40)
}
