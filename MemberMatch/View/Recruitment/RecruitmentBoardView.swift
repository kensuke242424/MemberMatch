//
//  PostingBoardView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI
import ScalingHeaderScrollView

enum Browsing {
    case all, single, group
}

struct RecruitmentBoardView: View {
    @EnvironmentObject var router: Router

    @StateObject private var vm = RecruitmentBoardViewModel()

    @State private var browsing: Browsing = .all

    var body: some View {
        VStack(spacing: 0) {
            TabTopBarView(
                "メンバー募集",
                leftToolbarItems: {},
                rightToolbarItems: {}
            )
            HStack {
                Text("すべて")
                    .fontWeight(.bold)
                    .opacity(browsing == .all ? 1 : 0.4)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .bottom) {
                        if browsing == .all {
                            RoundedRectangle(cornerRadius: 10).frame(height: 1).offset(y: 4)
                        }
                    }
                    .onTapGesture { withAnimation(.spring(duration: 0.4)) { browsing = .all } }
                Text("｜")
                Text("個人")
                    .fontWeight(.bold)
                    .opacity(browsing == .single ? 1 : 0.4)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .bottom) {
                        if browsing == .single {
                            RoundedRectangle(cornerRadius: 10).frame(height: 1).offset(y: 4)
                        }
                    }
                    .onTapGesture { withAnimation(.spring(duration: 0.4)) { browsing = .single } }
                Text("｜")
                Text("グループ")
                    .fontWeight(.bold)
                    .opacity(browsing == .group ? 1 : 0.4)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .bottom) {
                        if browsing == .group {
                            RoundedRectangle(cornerRadius: 10).frame(height: 1).offset(y: 4)
                        }
                    }
                    .onTapGesture { withAnimation(.spring(duration: 0.4)) { browsing = .group } }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(BlurView(style: .systemUltraThinMaterial))

            ScrollView() {
                Spacer().frame(height: 20) // スクロール下部の余白
                ForEach(vm.recruitments) { recruitment in
                    RecruitmentCard(recruitment: recruitment)
                }
                .padding(.horizontal)
                Spacer().frame(height: 20) // スクロール下部の余白
            }
        }
        .ignoresSafeArea(edges: .top)
        .gradientBackground()
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
        .environmentObject(Router())
}
