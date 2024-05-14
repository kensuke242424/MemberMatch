//
//  RecruitmentBoardViewModel.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import Foundation

class RecruitmentBoardViewModel: ObservableObject {
    @Published var recruitments: [Recruitment] = exampleRecruitments
}
