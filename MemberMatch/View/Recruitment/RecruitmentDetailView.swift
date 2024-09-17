//
//  PostDetailView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import ScalingHeaderScrollView
import SwiftUI
import SwiftUIIntrospect

struct RecruitmentDetailView: View {
    let recruitment: Recruitment
    @EnvironmentObject var router: Router
    @EnvironmentObject var userManager: UserManager

    @StateObject private var vm = RecruitmentDetailViewModel()
    @State private var scrollOffsetY: CGFloat = 0
    @State private var favorite: Bool = false

    let l10n = Constants.Strings.self

    var body: some View {
        VStack(spacing: 0) {
            TabTopBarView(
                l10n.recruitmentDetailPageTitle,
                leftToolbarItems: {
                    Image(systemName: Constants.Symbols.chevron_backward)
                        .foregroundStyle(.gray)
                        .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                        .background(Circle().foregroundStyle(.white))
                        .onTapGesture { router.popRecruitmentPage() }
                },
                rightToolbarItems: {
                    // 編集ボタン
                    if recruitment.author.id == userManager.currentUser.id {
                        NavigationLink(destination: CreateRecruitmentView(editData: recruitment)) {
                            Image(systemName:Constants.Symbols.square_and_pencil)
                                .foregroundStyle(.gray)
                                .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                                .background(Circle().foregroundStyle(.white))
                        }
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
                    recruitmentDetail(recruitment.description)
                    frequencyDetail(recruitment.frequency)
                    locationDetail(recruitment.rehearsalLocation)
                    youtubeVideoDetail(recruitment.youtubeVideoURL)
                    additionalInfoDetail(recruitment.additionalInfo)
                    socialMediaLinks(recruitment.author.socialMediaLinks).padding(.vertical, 16)
                    bottomActionButtons(recruitment).padding(.bottom, 16)
                }
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
        .gradientBackground()
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
    }
}

// 募集ボード
extension RecruitmentDetailView {
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
                CustomText(recruitment.title ?? l10n.emptyTitle, .customTextColorBlack)
                    .lineLimit(!vm.isScrolledMidPoint || vm.isFullOpenCard ? 10 : 1)
                    .font(!vm.isScrolledMidPoint || vm.isFullOpenCard ? .title3 : .subheadline)
                    .frame(maxWidth: .infinity,
                           alignment: !vm.isScrolledMidPoint || vm.isFullOpenCard ? .center : .leading)
                    .fontWeight(.bold)
                    .padding(.bottom, !vm.isScrolledMidPoint || vm.isFullOpenCard ? 10 : 0)
                HStack {
                    VStack(spacing: 8) {
                        CustomText(
                            "\(l10n.author)：\(recruitment.author.name ?? l10n.emptyName)",
                            .customTextColorBlack
                        )
                        .lineLimit(!vm.isScrolledMidPoint || vm.isFullOpenCard ? 100 : 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                        CustomText(recruitment.description ?? "入力なし", .gray)
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
                            Button(l10n.profileText) {
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
                    CustomText(l10n.favorite, .gray).font(.caption).fontWeight(.bold)
                    Image(systemName: favorite ? Constants.Symbols.heart_fill : Constants.Symbols.heart)
                        .foregroundStyle(favorite ? .red : .gray)
                        .onTapGesture { withAnimation { favorite.toggle() } }
                    CustomText(String(recruitment.favorite), .gray).font(.caption).fontWeight(.bold)
                    Spacer().frame(width: 20)
                    CustomText("\(l10n.publicDeadline):", .gray).font(.caption).fontWeight(.bold)
                    HStack(spacing: 5) {
                        CustomText(l10n.publicDeadlineDesc1, .gray).font(.caption).fontWeight(.bold)
                        CustomText(String(Util.daysUntilDeadline(from: recruitment.postedDate)), .gray)
                            .font(.caption).fontWeight(.bold)
                        CustomText(l10n.publicDeadlineDesc2, .gray).font(.caption).fontWeight(.bold)
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
extension RecruitmentDetailView {
    @ViewBuilder
    private func musicGenreDetail(_ genre: [MusicGenre]?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(l10n.musicGenreTitle)：", .customTextColorWhite)
                .font(.headline)
            Spacer().frame(height: 16)
            MusicGenresCapsuleView(genres: MusicGenre.allCases,
                                   highlightedGenres: .constant(genre ?? []),
                                   isEditing: false
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// 募集パート
extension RecruitmentDetailView {
    @ViewBuilder
    private func wantedPartsDetail(_ parts: [Part]) -> some View {
        let iconSize: CGFloat = 120
        var isWantedParts: [Part] {
            parts.filter { $0.isWanted == true }
        }

        VStack(alignment: .leading) {
            CustomText("\(l10n.wantedPartsTitle)：", .customTextColorWhite).font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    if isWantedParts.isEmpty {
                        EmptyPartView(l10n.emptyPart,
                                      symbolName: Constants.Symbols.questionmark,
                                      iconSize: iconSize
                        )
                    } else {
                        ForEach(isWantedParts) { part in
                            VStack(spacing: 10) {
                                Image(part.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .shadow(radius: 3)
                                HStack(spacing: 0) {
                                    Text(part.instrument.text)
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                    if part.gender != Gender.unknown {
                                        Text("(\(part.gender.text))")
                                            .font(.caption)
                                            .foregroundStyle(Color.gray)
                                    }
                                }
                            }
                        }
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
extension RecruitmentDetailView {
    @ViewBuilder
    private func policyDetail(_ policy: Policy?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(l10n.policyTitle)：", .customTextColorWhite).font(.headline)
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
extension RecruitmentDetailView {
    @ViewBuilder
    private func recruitmentDetail(_ description: String?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(l10n.recruitmentDescTitle)：", .customTextColorWhite)
                .font(.headline)
            VStack {
                CustomText(recruitment.title ?? l10n.emptyTitle, .customTextColorBlack).fontWeight(.bold)
                CustomText(description ?? l10n.emptyDescription, .customTextColorBlack)
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
extension RecruitmentDetailView {
    @ViewBuilder
    private func frequencyDetail(_ description: String?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(l10n.frequencyTitle)：", .customTextColorWhite)
                .font(.headline)
            CustomText(
                description ?? l10n.emptyDescription,
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
extension RecruitmentDetailView {
    @ViewBuilder
    private func locationDetail(_ description: String?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(l10n.locationTitle)：", .customTextColorWhite)
                .font(.headline)
            CustomText(
                description ?? l10n.emptyDescription,
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
extension RecruitmentDetailView {
    @ViewBuilder
    private func additionalInfoDetail(_ description: String?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(l10n.additionalInfoTitle)：", .customTextColorWhite)
                .font(.headline)
            CustomText(
                description ?? l10n.emptyDescription,
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

// Youtube動画
extension RecruitmentDetailView {
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
extension RecruitmentDetailView {
    @ViewBuilder
    private func socialMediaLinks(_ links: SocialMediaLinks) -> some View {
        let iconSize: CGFloat = 50

        VStack {
            Text("- SNS -")
                .tracking(2)
                .foregroundStyle(.customWhite)
            HStack(spacing: 30) {
                Button {
                    vm.openURL(links.twitter)
                } label: {
                    Image(Constants.Images.logo_X)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.6)
                        .frame(width: iconSize, height: iconSize)
                        .background(Circle().foregroundStyle(Color.black))
                        .overlay {
                            if links.twitter == nil {
                                Circle().foregroundStyle(Color.gray.opacity(0.7))
                            }
                        }
                }
                .disabled(links.twitter == nil)
                Button {
                    vm.openURL(links.instagram)
                } label: {
                    Image(Constants.Images.logo_Instagram)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.6)
                        .frame(width: iconSize, height: iconSize)
                        .background(Circle().foregroundStyle(Color.white))
                        .overlay {
                            if links.instagram == nil {
                                Circle().foregroundStyle(Color.gray.opacity(0.7))
                            }
                        }
                }
                .disabled(links.instagram == nil)
                Button {
                    vm.openURL(links.facebook)
                } label: {
                    Image(Constants.Images.logo_Facebook)
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize, height: iconSize)
                        .overlay {
                            if links.facebook == nil {
                                Circle().foregroundStyle(Color.gray.opacity(0.7))
                            }
                        }
                }
                .disabled(links.facebook == nil)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 24).foregroundStyle(.gray.opacity(0.3))
            }
        }
    }
}

extension RecruitmentDetailView {
    @ViewBuilder
    private func bottomActionButtons(_ recruitment: Recruitment) -> some View {
        if recruitment.author.id == UserManager.shared.currentUser.id {
            // 募集内容を編集する
            NavigationLink(destination: CreateRecruitmentView(editData: recruitment)) {
                HStack {
                    Text(l10n.editRecruitmentButtonText)
                    Image(systemName: Constants.Symbols.square_and_pencil)
                }
                .fontWeight(.bold)
                .foregroundStyle(.customWhite)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.customAccentYellow))
                .padding(4)
            }
        } else {
            HStack {
                // 気になる
                Button {
                    withAnimation { favorite.toggle() }
                } label: {
                    HStack {
                        Text(l10n.favorite)
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
                NavigationLink(destination: MessageView()) {
                    HStack {
                        Text(l10n.sendMessageButtonText)
                        Image(systemName: Constants.Symbols.bubble_left_fill)
                    }
                    .fontWeight(.bold)
                    .foregroundStyle(.customWhite)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.customAccentYellow))
                    .padding(4)
                }
            }
        }
    }
}

#Preview {
    RecruitmentDetailView(recruitment: exampleRecruitments[1])
        .environmentObject(Router.shared)
        .environmentObject(UserManager.shared)
}
