//
//  PostDetailView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import ScalingHeaderScrollView
import SwiftUI
import SwiftUIIntrospect

struct UserProfileView: View {
    let user: User
    @EnvironmentObject var router: Router

    @State private var resetScrollToTop: Bool = false
    @State private var collapseProgress: CGFloat = 0.0
    @State private var tabTopOpacity: CGFloat = 0.0

    let maxHeaderHeight: CGFloat = 320
    let minHeaderHeight: CGFloat = 100
    let overlapYOffset: CGFloat = 50

    var body: some View {
        ScalingHeaderScrollView(header: {
            Image("music_1")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .frame(height: maxHeaderHeight)
                .opacity(1 - collapseProgress)
        }, content: {
            VStack(spacing: -overlapYOffset) {
                Rectangle()
                    .foregroundStyle(
                        LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.3)]),
                                       startPoint: .init(x: 0, y: 0.7),
                                       endPoint: .init(x: 0, y: 1))
                    )
                    .shadow(radius: 2)
                    .blur(radius: 15)
                    .opacity(1 - collapseProgress)
                    .frame(height: maxHeaderHeight)
                    .zIndex(200)
                    .overlay(alignment: .bottomLeading) {
                        CustomText("Rock climb", .customTextColorWhite)
                            .zIndex(1000)
                            .tracking(1)
                            .font(.title3.bold())
                            .frame(height: overlapYOffset)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .opacity(1 - tabTopOpacity)
                            .padding(.horizontal)
                    }

                VStack {

                    Spacer().frame(height: overlapYOffset)

                    userDetail(user: mockUser).padding(.top)
                    wantedPartsDetail(title: "募集パート", desc: user.bio ?? "")
                    recruitmentDetail(title: "募集の内容", desc: user.bio ?? "")
                    frequencyDetail(title: "活動頻度", desc: user.bio ?? "")
                    locationDetail(title: "活動場所", desc: user.bio ?? "")

                    Button("メッセージを送る") {
                        resetScrollToTop = true
                    }
                    .fontWeight(.bold)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.customAccentYellow))
                    .foregroundStyle(.customWhite)
                    .padding()

                    Spacer().frame(height: 20)
                }
                .padding(.horizontal)
                .gradientBackground()
                .clippedToDeviceTopCorners()
                .shadow(radius: 6)
            }
            .padding(.top, -maxHeaderHeight)
            .zIndex(100)
            .onChange(of: collapseProgress) { newValue in
                if newValue > 0.9 {
                    withAnimation(.spring(duration: 0.2)) { tabTopOpacity = newValue }
                } else {
                    withAnimation(.spring(duration: 0.2)) { tabTopOpacity = 0.0 }
                }
            }
        })
        .scrollToTop(resetScroll: $resetScrollToTop) // スクロールリセット
        .allowsHeaderCollapse(true)
        .allowsHeaderGrowth()
        .setHeaderSnapMode(.disabled)
        .collapseProgress($collapseProgress) // ヘッダーの折りたたみ状況
        .height(min: minHeaderHeight, max: maxHeaderHeight) // ヘッダーの可変サイズ
        .overlay(alignment: .top) {
            tabTopBarView()
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private func tabTopBarView() -> some View {
            let iconSize: CGFloat = 30
            HStack {
                RoundedRectangle(cornerRadius: 10).frame(width: 30, height: 30)
                Text("Rock climb")
                    .tracking(1)
                    .lineLimit(1)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .contentShape(Rectangle())
            }
            .opacity(tabTopOpacity)
            .frame(maxWidth: .infinity)
            .onTapGesture { resetScrollToTop = true }
            .overlay {
                HStack {
                    Circle().frame(width: iconSize, height: iconSize).foregroundStyle(.white)
                        .overlay(Image(systemName: "arrow.left").foregroundColor(.gray))
                        .onTapGesture { router.popRecruitmentPage() }
                    Spacer()
                    Circle().frame(width: iconSize, height: iconSize).foregroundStyle(.white)
                        .overlay(Image(systemName: "ellipsis").foregroundStyle(.gray))
                        .onTapGesture {}
                } // HStack
                .padding(.horizontal, 20)
            }
            .padding(.top, 60)

        .frame(height: minHeaderHeight)
        .background(
            Color.clear.overlay {
                BlurView(style: .systemUltraThinMaterial).ignoresSafeArea(edges: .top)
            }
                .opacity(tabTopOpacity)
        )
    }
}

extension UserProfileView {
    @ViewBuilder
    private func userDetail(user: User) -> some View {
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
                    CustomText(user.skillLevel?.text ?? "", .customTextColorWhite).font(.caption)
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

extension UserProfileView {
    @ViewBuilder
    private func wantedPartsDetail(title: String, desc description: String) -> some View {
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

extension UserProfileView {
    @ViewBuilder
    private func recruitmentDetail(title: String, desc description: String) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(title)：", .customTextColorWhite)
                .font(.headline)
            VStack {
                CustomText(user.name ?? "", .customTextColorBlack).fontWeight(.bold)
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

extension UserProfileView {
    @ViewBuilder
    private func frequencyDetail(title: String, desc description: String?) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(title)：", .customTextColorWhite)
                .font(.headline)
            VStack {
                CustomText(user.name ?? "", .customTextColorBlack).fontWeight(.bold)
                CustomText(description ?? "記載なし", .customTextColorBlack)
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

extension UserProfileView {
    @ViewBuilder
    private func locationDetail(title: String, desc description: String) -> some View {
        VStack(alignment: .leading) {
            CustomText("\(title)：", .customTextColorWhite)
                .font(.headline)
            VStack {
                CustomText(user.name ?? "No Name", .customTextColorBlack).fontWeight(.bold)
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
    UserProfileView(user: mockUser)
        .environmentObject(Router())
}
