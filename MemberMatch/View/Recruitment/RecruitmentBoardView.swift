//
//  PostingBoardView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI

struct RecruitmentBoardView: View {
    @StateObject private var vm = RecruitmentBoardViewModel()
    @EnvironmentObject var router: Router

    var body: some View {

        VStack {
            ScrollView(content: {
                ForEach(vm.recruitments) { recruitment in
                    RecruitmentCard(recruitment: recruitment)
                }
                Spacer().frame(height: 20) // スクロール下部の余白
            })
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal)
        .gradientBackground()
        .navigationTitle("メンバー募集")
        .navigationBarTitleDisplayMode(.inline)

    }
}

extension RecruitmentBoardView {
    @ViewBuilder
    private func RecruitmentCard(recruitment: Recruitment) -> some View {
        Button {
            router.push([.detail(recruitment)])
        } label: {
            VStack(spacing: 4) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        CustomText(recruitment.title, .customTextColorBlack)
                            .lineLimit(1)
                            .fontWeight(.bold)
                        CustomText(recruitment.description, .gray)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Circle().foregroundStyle(.customAccentYellow).shadow(radius: 2)
                }
                HStack {
                    CustomText("気になる", .gray).font(.caption).fontWeight(.bold)
                    Image(systemName: "heart.fill").foregroundStyle(.red)
                    CustomText("50", .gray).font(.caption).fontWeight(.bold)
                    Spacer().frame(width: 20)
                    CustomText("残り期日：", .gray).font(.caption).fontWeight(.bold)
                    CustomText("7日", .gray).font(.caption).fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
            .padding(.vertical, 14)
            .frame(height: 130)
            .fixedSize(horizontal: false, vertical: true) // テキストが縦方向に展開
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5))
        }
    }
}

#Preview {
    RecruitmentBoardView()
}
