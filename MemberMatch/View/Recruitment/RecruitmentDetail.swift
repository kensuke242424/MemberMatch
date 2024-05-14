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
        ScrollView {
            VStack(spacing: 30) {
                UserDescription(user: exampleUsers.first!)
                    .padding(.vertical)
                DetailRow(title: "募集パート", desc: recruitment.description)
                DetailRow(title: "募集の内容", desc: recruitment.description)
                DetailRow(title: "活動頻度", desc: recruitment.description)
                DetailRow(title: "活動場所", desc: recruitment.description)

                Spacer().frame(height: 20)

                Button("メッセージを送る") {

                }
                .fontWeight(.bold)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.customAccentYellow))
                .foregroundStyle(.customWhite)

                Spacer().frame(height: 20)
            }
            .padding(.horizontal)
        }
        .gradientBackground()
        .navigationTitle("募集の内容")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension RecruitmentDetail {
    @ViewBuilder
    private func DetailRow(title: String, desc description: String) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(title)：", .customTextColorWhite)
                .font(.headline)
            VStack {
                CustomText(recruitment.title, .customTextColorBlack).fontWeight(.bold)
                CustomText(description, .customTextColorBlack)
                    .font(.subheadline)
                    .frame(minHeight: 50)
                    .frame(maxHeight: .infinity)
                Spacer().frame(height: 40)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .shadow(radius: 10)
                    .foregroundStyle(.customWhite)
            }
        }
    }
}

extension RecruitmentDetail {
    @ViewBuilder
    private func UserDescription(user: User) -> some View {
        let screenSize = UIScreen.main.bounds

        HStack(spacing: 30) {
            SDWebImageCircleIcon(nil,
                                 width: screenSize.width * 0.3,
                                 height: screenSize.width * 0.3,
                                 defaultIcon: "person.fill"
            )
            .onTapGesture {
                // ユーザープロフィールへ遷移
            }
            VStack(alignment: .leading, spacing: 15) {
                CustomText(user.name, .customTextColorWhite).font(.subheadline)
                CustomText(user.experienceLevel, .customTextColorWhite).font(.caption)
                CustomText(user.bio, .customTextColorWhite).font(.caption)
                    .fixedSize(horizontal: false, vertical: true) // テキストが縦方向に展開
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    RecruitmentDetail(recruitment: exampleRecruitments.first!)
}
