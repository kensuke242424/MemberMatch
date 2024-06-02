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

    var jpName: String {
        switch self {
        case .nothing: "こだわらない"
        case .hobby: "趣味として楽しむ"
        case .professional: "本気でやる"
        }
    }
}
