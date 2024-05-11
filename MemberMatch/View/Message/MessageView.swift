//
//  MessageView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        VStack {
            CustomText("MessageView", .customTextColorWhite)
        }
        .gradientBackground()
    }
}

#Preview {
    MessageView()
}
