//
//  PostDetailView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI

struct RecruitmentDetail: View {
    let recruitment: Recruitment

    var body: some View {
        VStack {
            CustomText(recruitment.title, .customTextColorWhite)
        }
        .gradientBackground()
    }
}

#Preview {
    RecruitmentDetail(recruitment: exampleRecruitments.first!)
}
