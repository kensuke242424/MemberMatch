//
//  Browse.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/06/01.
//

enum Browse: CaseIterable {
    case all, single, group

    var index: Int {
        switch self {
        case .all: 0
        case .single: 1
        case .group: 2
        }
    }

    var title: String {
        switch self {
        case .all: "全て"
        case .single: "個人"
        case .group: "グループ"
        }
    }
}
