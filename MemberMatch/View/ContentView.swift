//
//  Home.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/11/17.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appState: AppState = AppState.shared
    @StateObject private var router: Router = Router.shared
    @StateObject private var userManager = UserManager.shared

    var body: some View {
        if appState.isAuthenticated {
            RootTabView()
                .environmentObject(appState)
                .environmentObject(router)
                .environmentObject(userManager)
        } else {
            // TODO: ログイン画面
        }
    }
}

#Preview {
    ContentView()
}
