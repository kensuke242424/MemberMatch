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

            RecruitmentBoardView()
                .tabItem { Label("掲示板", systemImage: "list.bullet.clipboard") }
                .tag(1)

            NavigationStack {
                MemberScoutView()
            }
            .tabItem { Label("スカウト", systemImage: "sparkle.magnifyingglass") }
            .tag(2)

            NavigationStack {
                MessageView()
            }
            .tabItem { Label("メッセージ", systemImage: "bubble.left.fill") }
            .tag(3)

            NavigationStack {
                NotificationView()
            }
            .tabItem { Label("通知", systemImage: "bell") }
            .tag(4)

            NavigationStack {
                ProfileView()
            }
            .tabItem { Label("プロフ", systemImage: "person.crop.rectangle") }
            .tag(5)
        }
        //        .tint(.customWhite)
    }
}

extension RootView {
    func customTabItem() {

    }
}

#Preview {
    RootView()
}
