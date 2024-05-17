//
//  PostDetailView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI
import SwiftUIIntrospect
import ScalingHeaderScrollView

struct RecruitmentDetail: View {
    let recruitment: Recruitment

    @EnvironmentObject var router: Router

    @State private var resetScroll: Bool = false
    @State private var collapseProgress: CGFloat = 0.0

    @State private var isShowTopTab: Bool = false

    let headerHeight: CGFloat = 300
    let tabTopHeight: CGFloat = 80

    var body: some View {
        ScalingHeaderScrollView(header: {
            ZStack {
                VStack {
                    Image("music_2")
                        .resizable()
                        .scaledToFill()
                        .frame(height: headerHeight - 20)
                        .opacity(1 - collapseProgress)
                    Spacer()
                }

                VStack(spacing: 0) {
                    Spacer()
                    Rectangle()
//                        .foregroundStyle(.customMediumGray.gradient)
                        .frame(height: tabTopHeight)
                        .opacity(isShowTopTab ? 1 : 0)
                }
                .onChange(of: collapseProgress) { newValue in
                    if collapseProgress > 0.8 {
                        withAnimation { isShowTopTab = true }
                    } else {
                        withAnimation { isShowTopTab = false }
                    }
                }
            }
        }, content: {
            VStack {
                UserDetail(user: mockUser).padding(.top)
                WantedPartsDetail(title: "募集パート", desc: recruitment.description)
                RecruitmentDetail(title: "募集の内容", desc: recruitment.description)
                FrequencyDetail(title: "活動頻度", desc: recruitment.description)
                LocationDetail(title: "活動場所", desc: recruitment.rehearsalLocation)

                Spacer().frame(height: 20)

                Button("メッセージを送る") {
                    resetScroll = true
                }
                .fontWeight(.bold)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.customAccentYellow))
                .foregroundStyle(.customWhite)
                .padding()
            }
            .padding(.horizontal)

        })
        .scrollToTop(resetScroll: $resetScroll) // スクロールリセット
        .collapseProgress($collapseProgress) // ヘッダーの折りたたみ状況
        .height(min: tabTopHeight, max: headerHeight) // ヘッダーの可変サイズ
        .gradientBackground()
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
    }
}

extension RecruitmentDetail {
    @ViewBuilder
    private func UserDetail(user: User) -> some View {
        VStack {
            HStack(spacing: 30) {
                SDWebImageCircleIcon(nil,
                                     width: 130,
                                     height: 130,
                                     defaultIcon: "person.fill"
                )
                .onTapGesture {
                    router.push([.userProfile(mockUser)])
                }
                VStack(alignment: .leading, spacing: 15) {
                    CustomText(user.name ?? "", .customTextColorWhite).font(.subheadline)
                    CustomText(user.skillLevel?.jpName ?? "", .customTextColorWhite).font(.caption)
                    CustomText(user.bio ?? "", .customTextColorWhite).font(.caption)
                        .fixedSize(horizontal: false, vertical: true) // テキストが縦方向に展開
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer().frame(height: 20)
            Divider().frame(height: 0.8).background(.black.opacity(0.4)).padding(.horizontal, 30)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<4) { _ in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 200, height: 130)
                            .foregroundStyle(.customAccentYellow.gradient)
                    }
                }
                .padding(.vertical, 5)
            }
            Divider().frame(height: 0.8).background(.black.opacity(0.4)).padding(.horizontal, 30)
        }
    }
}

extension RecruitmentDetail {
    @ViewBuilder
    private func WantedPartsDetail(title: String, desc description: String) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(title)：", .customTextColorWhite).font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<8) { _ in
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.customAccentYellow.gradient)
                            .shadow(radius: 3)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 5)
                .padding(.horizontal, 5)
            }
            .padding(8)
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
    private func RecruitmentDetail(title: String, desc description: String) -> some View {
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
            .frame(maxWidth: .infinity)
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
    private func FrequencyDetail(title: String, desc description: String) -> some View {
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
            .frame(maxWidth: .infinity)
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
    private func LocationDetail(title: String, desc description: String) -> some View {
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
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .shadow(radius: 10)
                    .foregroundStyle(.customWhite)
            }
        }
    }
}

#Preview {
    RecruitmentDetail(recruitment: exampleRecruitments.first!)
        .environmentObject(Router())
}
