//
//  ContentView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/04/28.
//

import SwiftUI

struct RootTabView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var userManager: UserManager

    // タブアイコン非選択時のカラー
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }

    @StateObject private var vm = TabsViewModel()

    var body: some View {
        TabView(selection: $vm.selectionTabIndex) {
            NavigationStack(path: $router.recruitmentPagePath) {
                RecruitmentBoardView()
                    .navigationDestination(for: RecruitmentPagePath.self) { path in
                        switch path {
                        case .home:
                            RecruitmentBoardView()

                        case .detail(let recruitment):
                            RecruitmentDetailView(recruitment: recruitment)

                        case .userProfile(let user):
                            UserProfileView(user: user)

                        case .teamProfile(let team):
                            TeamProfileView(team: team)
                        }
                    }
            }
            .tabItem { Label("掲示板", systemImage: "list.bullet.clipboard") }
            .tag(1)

            NavigationStack(path: $router.notificationPagePath) {
                NotificationView()
                    .navigationDestination(for: NotificationPagePath.self) { path in
                        switch path {
                        case .home:
                            NotificationView()
                        }
                    }
            }
            .tabItem { Label("通知", systemImage: "bell") }
            .tag(2)

            NavigationStack(path: $router.profilePagePath) {
                ProfileView()
                    .navigationDestination(for: ProfilePagePath.self) { path in
                        switch path {
                        case .home:
                            ProfileView()
                        }
                    }
            }
            .tabItem { Label("プロフ", systemImage: "person.crop.rectangle") }
            .tag(3)

            NavigationStack(path: $router.profilePagePath) {
                SystemSettingView()
                    .navigationDestination(for: SystemSettingPagePath.self) { path in
                        switch path {
                        case .home:
                            ProfileView()
                        }
                    }
            }
            .tabItem { Label("設定", systemImage: "gearshape.fill") }
            .tag(4)
        } // TabView
        .onAppear {
            userManager.fetchUserData(userId: mockUser.id)
        }
    }
}

extension RootTabView {
    func customTabItem() {

    }
}

#Preview {
    RootTabView()
        .environmentObject(Router.shared)
}
