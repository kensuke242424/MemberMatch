//
//  SkillLevel.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/04/28.
//

enum SkillLevel: Int, CaseIterable, Codable {
    case beginner
    case novice
    case intermediate
    case advanced
    case expert

    var text: String {
        switch self {
        case .beginner: Constants.Strings.skill_level_beginner
        case .novice: Constants.Strings.skill_level_novice
        case .intermediate: Constants.Strings.skill_level_intermediate
        case .advanced: Constants.Strings.skill_level_advanced
        case .expert: Constants.Strings.skill_level_expert
        }
    }
}
