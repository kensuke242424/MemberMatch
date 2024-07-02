//
//  RecruitmentEditView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/01.
//

import SwiftUI

struct CreateRecruitmentView: View {
    let editData: Recruitment? = nil

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            if let editData {
                // TODO: 編集アイテムが渡されている場合は、各項目に値をセット
            }
        }
    }
}

#Preview {
    CreateRecruitmentView()
}
