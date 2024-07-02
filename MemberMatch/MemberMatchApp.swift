//
//  MemberMatchApp.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/04/28.
//

import SwiftUI

@main
struct MemberMatchApp: App {
    @StateObject var router: Router = Router.shared
    @StateObject private var userManager = UserManager.shared

    // TODO: Firebase.AuthのcurrentUserを使う
    @State private var dummyAuthCurrentUser: Bool = true

    var body: some Scene {
        WindowGroup {
            if dummyAuthCurrentUser {
                RootTabView()
                    .environmentObject(router)
                    .environmentObject(userManager)
            } else {
                // TODO: ログイン画面
            }
        }
    }
}
