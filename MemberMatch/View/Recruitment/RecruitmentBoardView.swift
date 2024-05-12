//
//  PostingBoardView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI

struct RecruitmentBoardView: View {
    @StateObject private var vm = RecruitmentBoardViewModel()

    var body: some View {
        NavigationStack(path: $vm.path) {
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
            .navigationTitle("掲示板")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: RecruitmentPath.self, destination: { destination in
                switch destination {
                case .home:
                    RecruitmentBoardView()

                case .detail(let recruitment):
                    RecruitmentDetail(recruitment: recruitment)
                }
            })
        }
    }
}

extension RecruitmentBoardView {
    @ViewBuilder
    private func RecruitmentCard(recruitment: Recruitment) -> some View {
        Button {
            vm.path.append(.detail(recruitment))
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    CustomText(recruitment.title, .customTextColorBlack)
                        .fontWeight(.bold)
                    CustomText(recruitment.description, .gray)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                }
                Circle().foregroundStyle(.customAccentYellow)
            }
            .padding()
            .frame(height: 80)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5))
            .padding(.vertical, 3)
        }
    }
}

#Preview {
    RecruitmentBoardView()
}
