//
//  Gender.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/06/09.
//

import Foundation

enum Gender: String, CaseIterable, Codable {
    case male = "Male"
    case female = "Female"
    case unknown = "Unknown"

    var text: String {
        switch self {
        case .male:
            "男性"
        case .female:
            "女性"
        case .unknown:
            "回答なし"
        }
    }
}
