//
//  SwiftUIView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/19.
//

import SwiftUI

struct CorkBoardView<Content: View>: View {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            // Corkboard background
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.corkTexture)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.woodFrame, lineWidth: 5)
                )
                .shadow(radius: 5)

            // Pinned paper content
            content
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .shadow(radius: 2)
                .overlay(alignment: .top) {
                    PinView(offsetX: 0, offsetY: -6)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct PinView: View {
    var offsetX: CGFloat
    var offsetY: CGFloat

    var body: some View {
        Circle()
            .fill(Color.red.gradient)
            .frame(width: 12, height: 12)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 0.3)
            )
            .offset(x: offsetX, y: offsetY)
    }
}

// Custom colors
extension Color {
    static let corkTexture = Color(red: 0.8, green: 0.7, blue: 0.5)
    static let woodFrame = Color(red: 0.5, green: 0.3, blue: 0.1)
}

#Preview {
    CorkBoardView(content: {
        VStack(content: {
            Text("Pinned Note")
            Text("Pinned Note")
            Text("Pinned Note")
            Text("Pinned Note")
            Text("Pinned Note")
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    })
}
