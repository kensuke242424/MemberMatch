//
//  CommitmentLevel.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/15.
//

enum CommitmentLevel: String, CaseIterable, Codable {
    case casual = "Casual"
    case serious = "Serious"
    case professional = "Professional"

    var jpName: String {
        switch self {
        case .casual:
            return "エンジョイ"
        case .serious:
            return "がっつり"
        case .professional:
            return "プロ志望"
        }
    }
}
