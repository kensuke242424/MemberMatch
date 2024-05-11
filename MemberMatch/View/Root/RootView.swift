//
//  ContentView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/04/28.
//

import SwiftUI

struct RootView: View {

    // タブアイコン非選択時のカラー
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }

    @StateObject private var vm = RootViewModel()

    @State private var selectionTabIndex = 1

    var body: some View {
        TabView(selection: $selectionTabIndex) {

            PostingBoardView()
                .tabItem { Label("掲示板", systemImage: "list.bullet.clipboard") }
                .tag(1)

            MemberScoutView()
                .tabItem { Label("スカウト", systemImage: "sparkle.magnifyingglass") }
                .tag(2)

            MessageView()
                .tabItem { Label("メッセージ", systemImage: "bubble.left.fill") }
                .tag(3)

            NotificationView()
                .tabItem { Label("通知", systemImage: "bell") }
                .tag(4)

            ProfileView()
                .tabItem { Label("プロフ", systemImage: "person.crop.rectangle") }
                .tag(5)
        }
        .tint(.customWhite)
    }
}

extension RootView {
    func customTabItem() {

    }
}

#Preview {
    RootView()
}
