//
//  Policy.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/06/02.
//

import Foundation

enum Policy: String, CaseIterable, Codable {
    case nothing = "Nothing"
    case hobby = "Hobby"
    case professional = "Professional"

    var text: String {
        switch self {
        case .nothing: Constants.Strings.policy_nothing
        case .hobby: Constants.Strings.policy_hobby
        case .professional: Constants.Strings.policy_professional
        }
    }
}
