//
//  CustomText.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI

struct CustomText: View {
    let text: String
    let color: Color

    init(_ text: String, _ color: Color) {
        self.text = text
        self.color = color
    }

    var body: some View {
        Text(text)
            .foregroundStyle(color)
    }
}

#Preview {
    CustomText("Hello!!", .customTextColorBlack)
}
