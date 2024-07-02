//
//  UserManager.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/01.
//

import Foundation

class UserManager: ObservableObject {
    static let shared = UserManager()

    @Published var currentUser: User?

    private init() {}

    // TODO: Firebaseから取得
    func fetchUserData(userId: String) {
        self.currentUser = mockUser
    }

    // TODO: Firebaseにアタッチ
    func updateUserData(newData: User) {
        self.currentUser = newData
    }
}
