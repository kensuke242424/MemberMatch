//
//  SkillLevel.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/04/28.
//

enum SkillLevel: Int, CaseIterable, Codable {
    case beginner = 1
    case novice
    case intermediate
    case advanced
    case expert

    var jpName: String {
        switch self {
        case .beginner:
            return "初心者"
        case .novice:
            return "初級"
        case .intermediate:
            return "中級"
        case .advanced:
            return "上級"
        case .expert:
            return "プロ"
        }
    }
}
