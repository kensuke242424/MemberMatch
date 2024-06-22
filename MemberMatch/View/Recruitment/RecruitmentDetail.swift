//
//  PostDetailView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import ScalingHeaderScrollView
import SwiftUI
import SwiftUIIntrospect

struct RecruitmentDetail: View {
    let recruitment: Recruitment
    @EnvironmentObject var router: Router

    @StateObject private var vm = RecruitmentDetailViewModel()

    @State private var scrollOffsetY: CGFloat = 0
    // TODO: ユーザーデータの投稿お気に入りパラメータから算出する
    @State private var favorite: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            TabTopBarView(
                Constants.Strings.recruitmentPageTitle,
                leftToolbarItems: {
                    Image(systemName: Constants.Symbols.chevron_backward)
                        .foregroundStyle(.gray)
                        .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                        .background(Circle().foregroundStyle(.white))
                        .onTapGesture { router.popRecruitmentPage() }
                },
                rightToolbarItems: {
                    // TODO: 自身の投稿の場合のみ編集可能
                    // 編集ボタン
                    Image(systemName:Constants.Symbols.square_and_pencil)
                        .foregroundStyle(.gray)
                        .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                        .background(Circle().foregroundStyle(vm.isEditing ? .customAccentYellow : .white))
                        .onTapGesture {
                            withAnimation { vm.isEditing.toggle() }
                        }
                    // ピン留めボタン
                    Image(systemName: vm.isFixedCard ? Constants.Symbols.pin_fill : Constants.Symbols.pin)
                        .foregroundStyle(.gray)
                        .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                        .background(Circle().foregroundStyle(.white))
                        .onTapGesture { vm.isFixedCard.toggle() }
                }
            )
            ScalingHeaderScrollView(header: {
                ZStack {
                    BlurView(style: .systemUltraThinMaterial).opacity(vm.isScrolledEndPoint ? 1 : 0)
                    recruitmentBoard(recruitment: recruitment)
                        .padding()
                        .onAppear {
                            // MEMO: タブ切り替えによって再度処理が走ることを防ぐ
                            if vm.isAlreadyShown { return }

                            vm.maxHeaderHeight = vm.recruitmentCardSize.height + 30
                            vm.isAlreadyShown.toggle()
                        }
                        .onTapGesture {
                            if vm.collapseProgress <= 0 { return }
                            withAnimation(.spring(duration: 0.2)) { vm.isFullOpenCard.toggle() }
                        }
                        .onPreferenceChange(SizePreferenceKey.self) { size in
                            vm.recruitmentCardSize = size
                        }
                        .onChange(of: scrollOffsetY) { _ in
                            withAnimation(.spring(duration: 0.2)) { vm.isFullOpenCard = false }
                        }
                }
            }, content: {
                VStack(spacing: 30) {
                    musicGenreDetail(recruitment.genre)
                    wantedPartsDetail(recruitment.wantedParts)
                    policyDetail(recruitment.policy)
                    frequencyDetail(recruitment.frequency)
                    locationDetail(recruitment.rehearsalLocation)
                    youtubeVideoDetail(recruitment.youtubeVideoURL)
                    additionalInfoDetail(recruitment.additionalInfo)
                    socialMediaLinks(recruitment.author.socialMediaLinks)
                        .padding(.vertical, 15)
                    HStack {
                        // 気になる
                        Button {
                            withAnimation { favorite.toggle() }
                        } label: {
                            HStack {
                                Text(Constants.Strings.favorite)
                                Image(systemName: favorite ? Constants.Symbols.heart_fill : Constants.Symbols.heart)
                            }
                            .opacity(favorite ? 1 : 0.7)
                        }
                        .fontWeight(.bold)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(favorite ? .red : .gray)
                        )
                        .foregroundStyle(.customWhite)
                        .padding(4)
                        // メッセージを送る
                        Button {
                            vm.resetScrollToTop()
                        } label: {
                            HStack {
                                Text(Constants.Strings.sendMessage)
                                Image(systemName: Constants.Symbols.bubble_left_fill)
                            }
                        }
                        .fontWeight(.bold)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.customAccentYellow))
                        .foregroundStyle(.customWhite)
                        .padding(4)
                    }
                    .padding(.bottom, 15)
                }
                .editingScaleEffect(isEditing: $vm.isEditing)
                .padding()
                .offsetRect { rect in
                    scrollOffsetY = rect.minY - rect.height
                }
            })
            .height(min: vm.isFullOpenCard ? vm.maxHeaderHeight : vm.minHeaderHeight,
                    max: vm.maxHeaderHeight
            )
            .scrollToTop(resetScroll: $vm.isResetScroll)
            .allowsHeaderCollapse()
            .headerAlignment(.top)
            .allowsHeaderGrowth()
            .collapseProgress($vm.collapseProgress)
        }
        .background {
            if vm.isEditing {
                Color.black.opacity(0.4).ignoresSafeArea()
            }
        }
        .gradientBackground()
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
    }
}

// 募集ボード
extension RecruitmentDetail {
    struct SizePreferenceKey: PreferenceKey {
        typealias Value = CGSize

        static var defaultValue: Value = .zero

        static func reduce(value: inout Value, nextValue: () -> Value) {
            value = nextValue()
        }
    }

    @ViewBuilder
    private func recruitmentBoard(recruitment: Recruitment) -> some View {
        ZStack {
            // 募集コルクボード
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
                    .lineLimit(!vm.isScrolledMidPoint || vm.isFullOpenCard ? 10 : 1)
                    .font(!vm.isScrolledMidPoint || vm.isFullOpenCard ? .title3 : .subheadline)
                    .frame(maxWidth: .infinity,
                           alignment: !vm.isScrolledMidPoint || vm.isFullOpenCard ? .center : .leading)
                    .fontWeight(.bold)
                    .padding(.bottom, !vm.isScrolledMidPoint || vm.isFullOpenCard ? 10 : 0)
                HStack {
                    VStack(spacing: 8) {
                        CustomText(
                            "\(Constants.Strings.author)：\(recruitment.author.name ?? Constants.Strings.emptyName)",
                            .customTextColorBlack
                        )
                        .lineLimit(!vm.isScrolledMidPoint || vm.isFullOpenCard ? 100 : 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                        CustomText(recruitment.description, .gray)
                            .lineLimit(!vm.isScrolledMidPoint || vm.isFullOpenCard ? 4 : 2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .font(.caption)
                    }

                    VStack {
                        Circle()
                            .foregroundStyle(.customAccentYellow)
                            .shadow(radius: 2)
                            .frame(width: !vm.isScrolledMidPoint || vm.isFullOpenCard ? 70 : 50,
                                   height: !vm.isScrolledMidPoint || vm.isFullOpenCard ? 70 : 50)

                        if !vm.isScrolledMidPoint || vm.isFullOpenCard {
                            Button(Constants.Strings.profileText) {
                                router.push([.userProfile(mockUser)])
                            }
                            .font(.caption2.bold())
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding(.leading, 5)
                }
                .padding(.bottom, !vm.isScrolledMidPoint || vm.isFullOpenCard ? 10 : 0)

                HStack {
                    CustomText(Constants.Strings.favorite, .gray).font(.caption).fontWeight(.bold)
                    Image(systemName: favorite ? Constants.Symbols.heart_fill : Constants.Symbols.heart)
                        .foregroundStyle(favorite ? .red : .gray)
                        .onTapGesture { withAnimation { favorite.toggle() } }
                    CustomText(String(recruitment.favorite), .gray).font(.caption).fontWeight(.bold)
                    Spacer().frame(width: 20)
                    CustomText("\(Constants.Strings.publicDeadline):", .gray).font(.caption).fontWeight(.bold)
                    HStack(spacing: 5) {
                        CustomText(Constants.Strings.publicDeadlineDesc1, .gray).font(.caption).fontWeight(.bold)
                        CustomText(String(Util.daysUntilDeadline(from: recruitment.postedDate)), .gray)
                            .font(.caption).fontWeight(.bold)
                        CustomText(Constants.Strings.publicDeadlineDesc2, .gray).font(.caption).fontWeight(.bold)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                if !vm.isScrolledStartPoint || vm.isFullOpenCard {
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

// ジャンル
extension RecruitmentDetail {
    @ViewBuilder
    private func musicGenreDetail(_ genre: [MusicGenre]) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(Constants.Strings.musicGenreTitle)：", .customTextColorWhite)
                .font(.headline)
            Spacer().frame(height: 16)
            CapsuleView(texts: Constants.musicGenreTexts,
                        highlightedTexts: genre.map { $0.text }
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// 募集パート
extension RecruitmentDetail {
    @ViewBuilder
    private func wantedPartsDetail(_ parts: [Part]?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(Constants.Strings.wantedPartsTitle)：", .customTextColorWhite).font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    if let parts {
                        ForEach(parts) { part in
                            VStack(spacing: 10) {
                                // TODO: 性別指定なしの場合は、currentUserの性別を使う
                                Image(part.instrument.iconName(for: part.gender ?? Gender.male))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .shadow(radius: 3)
                                HStack(spacing: 0) {
                                    Text(part.instrument.text)
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                    if let gender = part.gender {
                                        Text("(\(gender.text))")
                                            .font(.caption)
                                            .foregroundStyle(Color.gray)
                                    }
                                }
                            }
                        }
                    } else {
                        // TODO: 募集パートなしの場合のアイコン
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

// 活動方針
extension RecruitmentDetail {
    @ViewBuilder
    private func policyDetail(_ policy: Policy?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(Constants.Strings.policyTitle)：", .customTextColorWhite).font(.headline)
            VStack {
                CustomText(policy?.text ?? "", .customTextColorBlack)
                    .tracking(4)
                    .font(.headline)
                Image(Constants.Images.band_enjoy)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .shadow(radius: 3)
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

// 募集詳細
extension RecruitmentDetail {
    @ViewBuilder
    private func recruitmentDetail(title: String, desc description: String) -> some View {
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

// 活動頻度
extension RecruitmentDetail {
    @ViewBuilder
    private func frequencyDetail(_ description: String?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(Constants.Strings.frequencyTitle)：", .customTextColorWhite)
                .font(.headline)
            CustomText(
                description ?? Constants.Strings.emptyDescription,
                description == nil ? .gray : .customTextColorBlack
            )
            .font(.subheadline)
            .frame(maxHeight: .infinity)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .shadow(radius: 10)
                    .foregroundStyle(.customWhite)
            }
        }
    }
}

// 活動拠点
extension RecruitmentDetail {
    @ViewBuilder
    private func locationDetail(_ description: String?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(Constants.Strings.locationTitle)：", .customTextColorWhite)
                .font(.headline)
            CustomText(
                description ?? Constants.Strings.emptyDescription,
                description == nil ? .gray : .customTextColorBlack
            )
            .font(.subheadline)
            .frame(maxHeight: .infinity)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .shadow(radius: 10)
                    .foregroundStyle(.customWhite)
            }
        }
    }
}

// 活動拠点
extension RecruitmentDetail {
    @ViewBuilder
    private func additionalInfoDetail(_ description: String?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(Constants.Strings.additionalInfoTitle)：", .customTextColorWhite)
                .font(.headline)
            CustomText(
                description ?? Constants.Strings.emptyDescription,
                description == nil ? .gray : .customTextColorBlack
            )
            .font(.subheadline)
            .frame(maxHeight: .infinity)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .shadow(radius: 10)
                    .foregroundStyle(.customWhite)
            }
        }
        .editingScaleEffect(isEditing: $vm.isEditing)
    }
}

// Youtube動画
extension RecruitmentDetail {
    @ViewBuilder
    private func youtubeVideoDetail(_ videoURL: [URL]?) -> some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .overlay { Text("YouTube") }
        }
    }
}

// SNSリンク
extension RecruitmentDetail {
    @ViewBuilder
    private func socialMediaLinks(_ links: SocialMediaLinks) -> some View {
        let iconSize: CGFloat = 50

        if vm.isEditing {
            VStack(spacing: 12) {
                textFieldForm(title: "X(Twitter)",
                              text: $vm.inputTwitterUrl,
                              Constants.Strings.placeHolderTwitterURL
                )
                textFieldForm(title: "Instagram",
                              text: $vm.inputInstagramUrl,
                              Constants.Strings.placeHolderInstagramURL
                )
                textFieldForm(title: "Facebook",
                              text: $vm.inputFacebookUrl,
                              Constants.Strings.placeHolderFacebookURL
                )
            }
        } else {
            HStack(spacing: 30) {
                Button {
                    vm.openURL(links.twitter)
                } label: {
                    Circle().frame(width: iconSize, height: iconSize)
                }
                .disabled(links.twitter == nil)
                Button {
                    vm.openURL(links.instagram)
                } label: {
                    Circle().frame(width: iconSize, height: iconSize)
                }
                .disabled(links.instagram == nil)
                Button {
                    vm.openURL(links.facebook)
                } label: {
                    Circle().frame(width: iconSize, height: iconSize)
                }
                .disabled(links.facebook == nil)
            }
        }
    }
}

extension RecruitmentDetail {
    @ViewBuilder
    private func textFieldForm(title: String, text: Binding<String>, _ placeHolder: String) -> some View {
        VStack(alignment: .leading) {
            CustomText(title, .customTextColorWhite)
                .font(.headline)

            TextField("", text: text)
                .overlay(alignment:  .leading) {
                    if text.wrappedValue.isEmpty {
                        Text(placeHolder)
                            .foregroundStyle(.gray.opacity(0.7))
                            .allowsHitTesting(false)
                    }
                }
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.white)
                }
                .foregroundStyle(.customTextColorBlack)
        }
    }
}

#Preview {
    RecruitmentDetail(recruitment: exampleRecruitments[1])
        .environmentObject(Router())
}
