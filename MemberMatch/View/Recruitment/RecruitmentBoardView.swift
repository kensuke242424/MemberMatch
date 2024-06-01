//
//  PostingBoardView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI
import ScalingHeaderScrollView

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

struct RecruitmentBoardView: View {
    @EnvironmentObject var router: Router

    @StateObject private var vm = RecruitmentBoardViewModel()

    @State private var browsing: Browse = .all
    @State private var pageTabIndex = 1
    @State private var browsingOffset: CGFloat = 0
    @State private var indicatorWidth: CGFloat = 0
    @State private var indicatorPosition: CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            TabTopBarView(
                "募集掲示板",
                leftToolbarItems: {},
                rightToolbarItems: {}
            )
            HStack {
                ForEach(Browse.allCases, id: \.self) { browse in
                    Text(browse.title)
                        .fontWeight(.bold)
                        .opacity(browsing == browse ? 1 : 0.4)
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .bottom) {
                            if browsing == browse {
                                RoundedRectangle(cornerRadius: 10).frame(height: 1).offset(y: 4)
                            }
                        }
                        .background {
                            Color.black.opacity(0.0001)
                                .onTapGesture {
                                    withAnimation(.spring(duration: 0.4)) { browsing = browse }
                                }
                        }
                    if browse != .group {
                        Text("｜")
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(BlurView(style: .systemUltraThinMaterial))

            TabView(selection: $browsing) {
                BrowseContentAll().tag(Browse.all)
                BrowseContentSingle().tag(Browse.single)
                BrowseContentGroup().tag(Browse.group)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .ignoresSafeArea(edges: .top)
        .gradientBackground()
    }
}

extension RecruitmentBoardView {
    @ViewBuilder
    private func BrowseContentAll() -> some View {
        ScrollView() {
            Spacer().frame(height: 20) // スクロール下部の余白
            ForEach(vm.recruitments) { recruitment in
                RecruitmentCard(recruitment: recruitment)
            }
            .padding(.horizontal)
            Spacer().frame(height: 20) // スクロール下部の余白
        }
        .gradientBackground()
        .offsetX { rect in
            if browsing == .all {
                browsingOffset = rect.minX - rect.width * CGFloat(Browse.all.index)
            }
        }
    }

    @ViewBuilder
    private func BrowseContentSingle() -> some View {
        ScrollView() {
            Spacer().frame(height: 20) // スクロール下部の余白
            ForEach(vm.recruitments) { recruitment in
                RecruitmentCard(recruitment: recruitment)
            }
            .padding(.horizontal)
            Spacer().frame(height: 20) // スクロール下部の余白
        }
        .gradientBackground()
        .offsetX { rect in
            if browsing == .single {
                browsingOffset = rect.minX - rect.width * CGFloat(Browse.single.index)
            }
        }
    }

    @ViewBuilder
    private func BrowseContentGroup() -> some View {
        ScrollView() {
            Spacer().frame(height: 20) // スクロール下部の余白
            ForEach(vm.recruitments) { recruitment in
                RecruitmentCard(recruitment: recruitment)
            }
            .padding(.horizontal)
            Spacer().frame(height: 20) // スクロール下部の余白
        }
        .gradientBackground()
        .offsetX { rect in
            if browsing == .group {
                browsingOffset = rect.minX - rect.width * CGFloat(Browse.group.index)
            }
        }
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
