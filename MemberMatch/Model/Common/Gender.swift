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
            Constants.Strings.gender_male
        case .female:
            Constants.Strings.gender_female
        case .unknown:
            Constants.Strings.gender_unknown
        }
    }
}
