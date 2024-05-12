//
//  RecruitmentBoardViewModel.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import Foundation

enum RecruitmentPath: Hashable {
    case home
    case detail(Recruitment)
}

class RecruitmentBoardViewModel: ObservableObject {
    @Published var recruitments: [Recruitment] = exampleRecruitments
    @Published var path: [RecruitmentPath] = .init()
}
