//
//  UserManager.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/01.
//

import Foundation

enum UserState {
    case loggedIn(User)
    case guest
}

class UserManager: ObservableObject {
    static let shared = UserManager()

    @Published var userState: UserState = .guest
    var currentUser: User {
        switch userState {
        case .loggedIn(let user):
            return user
        case .guest:
            return guestUser
        }
    }

    private init() {}

    // TODO: Firebaseから取得
    func fetchUserData(userId: String) {
        self.userState = .loggedIn(mockUser)
    }

    // TODO: Firebaseにアタッチ
    func updateUserData(newData: User) {
        self.userState = .loggedIn(newData)
    }
}
