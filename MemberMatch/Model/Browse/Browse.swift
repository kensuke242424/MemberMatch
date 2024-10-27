//
//  Browse.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/06/01.
//

enum Browse: CaseIterable {
    case all, favorite, myself

    var index: Int {
        switch self {
        case .all: 0
        case .favorite: 1
        case .myself: 2
        }
    }

    var title: String {
        switch self {
        case .all: "全て"
        case .favorite: "気になる"
        case .myself: "自分の投稿"
        }
    }
}
