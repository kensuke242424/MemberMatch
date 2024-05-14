//
//  RootView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/13.
//

import SwiftUI

struct RootView: View {
    @StateObject var router: Router = .init()
    var body: some View {
        TabsView()
            .environmentObject(router)
    }
}

#Preview {
    RootView()
        .environmentObject(Router())
}
