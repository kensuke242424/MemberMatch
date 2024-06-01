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

    @StateObject var vm = RecruitmentDetailViewModel()

    var body: some View {
        VStack(spacing: 0) {
            TabTopBarView(
                "募集の内容",
                leftToolbarItems: {
                    Image(systemName: Constants.Symbol_chevron_backward)
                        .foregroundStyle(.gray)
                        .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                        .background(Circle().foregroundStyle(.white))
                        .onTapGesture { router.popRecruitmentPage() }
                },
                rightToolbarItems: {
                    Image(systemName: vm.isFixedCard ?
                          Constants.Symbol_pin_fill : Constants.Symbol_pin)
                        .foregroundStyle(.gray)
                        .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                        .background(Circle().foregroundStyle(.white))
                        .onTapGesture { vm.isFixedCard.toggle() }
                }
            )
            ScalingHeaderScrollView(header: {
                ZStack {
                    BlurView(style: .systemUltraThinMaterial).opacity(vm.isScrolledEndPoint ? 1 : 0)
                    RecruitmentCard(recruitment: recruitment)
                        .padding()
                        .onTapGesture {
                            if vm.collapseProgress <= 0 { return }
                            withAnimation(.spring(duration: 0.2)){ vm.isOpenHeaderContents.toggle()}
                        }
                        .onPreferenceChange(SizePreferenceKey.self) { size in
                            vm.recruitmentCardSize = size
                        }
                        .onAppear{
                            //MEMO: タブ切り替えによって再度処理が走ることを防ぐ
                            if vm.isAlreadyShown { return }
                            vm.maxHeaderHeight = vm.recruitmentCardSize.height + 30
                            vm.isAlreadyShown.toggle()
                        }
                }
            }, content: {
                VStack {
                    WantedPartsDetail(title: "募集パート", desc: recruitment.description)
                    RecruitmentDetail(title: "募集の内容", desc: recruitment.description)
                    FrequencyDetail(title: "活動頻度", desc: recruitment.description)
                    LocationDetail(title: "活動場所", desc: recruitment.rehearsalLocation)

                    Button("メッセージを送る") {
                        vm.resetScrollToTop()
                    }
                    .fontWeight(.bold)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.customAccentYellow))
                    .foregroundStyle(.customWhite)
                    .padding()

                    Spacer().frame(height: 20)
                }
                .padding(.horizontal)
                .padding(.vertical)
            })
            .height(min: vm.isOpenHeaderContents ? vm.maxHeaderHeight : vm.minHeaderHeight,
                    max: vm.maxHeaderHeight
            )
            .scrollToTop(resetScroll: $vm.isResetScroll)
            .allowsHeaderCollapse()
            .headerAlignment(.top)
            .allowsHeaderGrowth()
            .collapseProgress($vm.collapseProgress)
        }
        .gradientBackground()
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension RecruitmentDetail {
    @ViewBuilder
    private func RecruitmentCard(recruitment: Recruitment) -> some View {
        ZStack {
            // コルクボードデザイン
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.corkTexture)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.woodFrame, lineWidth: 5)
                )
                .shadow(radius: 5)

            // 紙デザインの要素
            VStack(spacing: 4) {
                CustomText(recruitment.title, .customTextColorBlack)
                    .lineLimit(!vm.isScrolledMidPoint || vm.isOpenHeaderContents  ? 10 : 1)
                    .font(!vm.isScrolledMidPoint || vm.isOpenHeaderContents ? .title3 : .subheadline)
                    .frame(maxWidth: .infinity,
                           alignment: !vm.isScrolledMidPoint || vm.isOpenHeaderContents ? .center : .leading)
                    .fontWeight(.bold)
                    .padding(.bottom, !vm.isScrolledMidPoint || vm.isOpenHeaderContents ? 10 : 0)
                HStack {
                    VStack(spacing: 8) {
                        CustomText("掲載者：\(recruitment.user.name ?? "名無し")", .black)
                            .lineLimit(!vm.isScrolledMidPoint || vm.isOpenHeaderContents ? 100 : 2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .font(.caption)
                        CustomText(recruitment.description, .gray)
                            .lineLimit(!vm.isScrolledMidPoint || vm.isOpenHeaderContents ? 100 : 2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .font(.caption)
                    }

                    VStack {
                        Circle()
                            .foregroundStyle(.customAccentYellow)
                            .shadow(radius: 2)
                            .frame(width: !vm.isScrolledMidPoint || vm.isOpenHeaderContents ? 70 : 50,
                                   height: !vm.isScrolledMidPoint || vm.isOpenHeaderContents ? 70 : 50)

                        if !vm.isScrolledMidPoint || vm.isOpenHeaderContents {
                            Button("Profile") {
                                router.push([.userProfile(mockUser)])
                            }
                            .font(.caption2.bold())
                            .buttonStyle(.borderedProminent)

                        }
                    }
                    .padding(.leading, 5)
                }
                .padding(.bottom, !vm.isScrolledMidPoint || vm.isOpenHeaderContents ? 10 : 0)

                HStack {
                    CustomText("気になる", .gray).font(.caption).fontWeight(.bold)
                    Image(systemName: "heart.fill").foregroundStyle(.red)
                    CustomText("50", .gray).font(.caption).fontWeight(.bold)
                    Spacer().frame(width: 20)
                    CustomText("掲載日：あと 7日", .gray).font(.caption).fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                if !vm.isScrolledStartPoint || vm.isOpenHeaderContents {
                    VStack {
                        Divider().frame(height: 0.2).background(.black.opacity(0.1)).padding(.horizontal, 30)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<4) { _ in
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 150, height: 100)
                                        .foregroundStyle(.customAccentYellow.gradient)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                        Divider().frame(height: 0.2).background(.black.opacity(0.1)).padding(.horizontal, 30)
                    }
                    .padding(.top)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 14)
            .fixedSize(horizontal: false, vertical: true) // テキストが縦方向に展開
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(RoundedRectangle(cornerRadius: 2).fill(Color.white).shadow(radius: 5))
            .overlay(alignment: .top) {
                PinView(offsetX: 0, offsetY: -6)
            }
            .padding(8)
        }
        .overlay {
            GeometryReader { geometry in
                Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
            }
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
