//
//  NotificationView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        VStack {
            CustomText("NotificationView", .customTextColorWhite)
        }
        .gradientBackground()
    }
}

#Preview {
    NotificationView()
}
