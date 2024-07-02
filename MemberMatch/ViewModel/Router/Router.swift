//
//  Router.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/13.
//

import SwiftUI

enum RecruitmentPagePath: Hashable {
    case home
    case detail(Recruitment)
    case userProfile(User)
    case teamProfile(Team)
}

enum MemberScoutPagePath: Hashable {
    case home
}

enum MessagePagePath: Hashable {
    case home
}

enum ProfilePagePath: Hashable {
    case home
}

enum NotificationPagePath: Hashable {
    case home
}

class Router: ObservableObject {
    static let shared = Router()

    private init() {}
    
    @Published var recruitmentPagePath: [RecruitmentPagePath] = []
    @Published var memberScoutPagePath: [MemberScoutPagePath] = []
    @Published var messagePagePath: [MessagePagePath] = []
    @Published var notificationPagePath: [NotificationPagePath] = []
    @Published var profilePagePath: [ProfilePagePath] = []

    func push(_ path: [RecruitmentPagePath]) {
        recruitmentPagePath.append(contentsOf: path)
    }
    func push(_ path: [MemberScoutPagePath]) {
        memberScoutPagePath.append(contentsOf: path)
    }
    func push(_ path: [MessagePagePath]) {
        messagePagePath.append(contentsOf: path)
    }
    func push(_ path: [NotificationPagePath]) {
        notificationPagePath.append(contentsOf: path)
    }
    func push(_ path: [ProfilePagePath]) {
        profilePagePath.append(contentsOf: path)
    }

    func popRecruitmentPage() {
        recruitmentPagePath.removeLast()
    }
    func popMemberScoutPage() {
        memberScoutPagePath.removeLast()
    }
    func popMassagePage() {
        messagePagePath.removeLast()
    }
    func popNotificationPage() {
        notificationPagePath.removeLast()
    }
    func popProfilePage() {
        profilePagePath.removeLast()
    }
}
