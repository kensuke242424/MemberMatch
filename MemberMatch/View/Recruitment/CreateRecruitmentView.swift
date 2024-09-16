//
//  RecruitmentEditView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/01.
//

import PhotosUI
import SwiftUI

struct CreateRecruitmentView: View {
    var editData: Recruitment?
    @EnvironmentObject var router: Router
    @EnvironmentObject var userManager: UserManager

    @Environment(\.presentationMode) var presentationMode

    @StateObject private var vm = CreateRecruitmentViewModel()
    private let l10n = Constants.Strings.self

    var body: some View {
        VStack {
            TabTopBarView(
                editData == nil ? l10n.createRecruitmentPageTitle : l10n.editRecruitmentPageTitle,
                leftToolbarItems: {
                    Image(systemName: Constants.Symbols.chevron_backward)
                        .foregroundStyle(.gray)
                        .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                        .background(Circle().foregroundStyle(.white))
                        .onTapGesture { presentationMode.wrappedValue.dismiss() }
                },
                rightToolbarItems: {
                    if let editData {
                        createRecruitmentToolbarButton(l10n.editRecruitmentToolbarButtonText) {
                            vm.editRecruitment(editData: editData)
                            presentationMode.wrappedValue.dismiss()
                        }
                    } else {
                        createRecruitmentToolbarButton(l10n.createRecruitmentToolbarButtonText) {
                            vm.createRecruitment()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            )

            ScrollView {
                VStack(spacing: 40) {
                    // タイトル
                    singleLineTextFormField(l10n.placeHolderTitle,
                                            title: l10n.recruitmentTitleTitle,
                                            text: $vm.inputTitle
                    )
                    // 募集パート
                    wantedPartsSelectionForm(title: l10n.wantedPartsTitle,
                                             parts: vm.inputWantedParts
                    )
                    // 募集詳細
                    multiLineTextFormField(l10n.placeHolderDescription,
                                           title: l10n.recruitmentDescTitle,
                                           text: $vm.inputDescription
                    )
                    // 写真
                    selectImagesFormField(title: l10n.photoTitle,
                                          images: vm.inputImages,
                                          selection: vm.selectionImages
                    )
                    // ジャンル
                    musicGenreSelectFormField(title: l10n.musicGenreTitle,
                                              genres: MusicGenre.allCases,
                                              highlightedGenres: $vm.inputMusicGenre
                    )
                    // 活動頻度
                    singleLineTextFormField(l10n.placeHolderFrequency,
                                            title: l10n.frequencyTitle,
                                            text: $vm.inputFrequency
                    )
                    // 活動拠点
                    singleLineTextFormField(l10n.placeHolderRehearsalLocation,
                                            title: l10n.locationTitle,
                                            text: $vm.inputRehearsalLocation
                    )
                    // その他/備考
                    multiLineTextFormField(l10n.placeHolderAdditionalInfo,
                                           title: l10n.additionalInfoTitle,
                                           text: $vm.inputAdditionalInfo
                    )
                    // Youtube
                    youtubeFormField(title: l10n.youtubeTitle,
                                     url: $vm.inputYoutubeURL
                    )
                    // SNS URLs
                    VStack(spacing: 16) {
                        // X(Twitter)
                        singleLineTextFormField(l10n.placeHolderTwitterURL,
                                                title: l10n.twitterTitle,
                                                text: $vm.inputTwitterURL
                        )
                        // Instagram
                        singleLineTextFormField(l10n.placeHolderInstagramURL,
                                                title: l10n.instagramTitle,
                                                text: $vm.inputInstagramURL
                        )
                        // Facebook
                        singleLineTextFormField(l10n.placeHolderFacebookURL,
                                                title: l10n.facebookTitle,
                                                text: $vm.inputFacebookURL
                        )
                    }
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.gray).opacity(0.2))
                }
                .padding()
                .padding(.vertical, 20)
                .hideKeyboardToolbarButton()
                .cropImagePicker(option: .rectangle, show: $vm.isShowPicker, croppedImage: $vm.selectedImage)
                .onChange(of: vm.selectedImage) { newImage in
                    if let newImage {
                        vm.selectionImages.append(newImage)
                        vm.selectedImage = nil
                    }
                }
                .sheet(isPresented: $vm.isShowSelectPartSheet) {
                    SelectWantedPartView(selectionPart: $vm.inputWantedParts)
                }
            }
        }
        .gradientBackground()
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
        .onAppear {
            if let editData {
                // すでに存在するデータの編集の場合は、データの各値をinputにセット
                vm.setEditData(editData)
            }
        }
    }

    @ViewBuilder
    private func createRecruitmentToolbarButton(_ text: String, _ action: @escaping () -> Void) -> some View {
        Button(text) {
            action()
        }
        .font(.subheadline.bold())
        .foregroundStyle(.white)
        .padding(.vertical, 4)
        .padding(.horizontal, 10)
        .background {
            Capsule().foregroundStyle(.customAccentYellow.gradient)
        }
    }
}

// 一行テキストフィールド
extension CreateRecruitmentView {
    @ViewBuilder
    private func singleLineTextFormField(_ placeHolder: String, title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            CustomText("▫️\(title)", .customTextColorWhite)
                .font(.headline)

            TextField("", text: text)
                .autocapitalization(.none)
                .overlay(alignment:  .leading) {
                    if text.wrappedValue.isEmpty {
                        Text(placeHolder)
                            .foregroundStyle(.gray.opacity(0.5))
                            .allowsHitTesting(false)
                    }
                }
                .padding(16)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.white)
                }
                .foregroundStyle(.customTextColorBlack)
        }
    }
}

// 複数行、改行が可能なテキストフィールド
extension CreateRecruitmentView {
    @ViewBuilder
    private func multiLineTextFormField(_ placeHolder: String, title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            CustomText("▫️\(title)", .customTextColorWhite)
                .autocapitalization(.none)
                .font(.headline)
            TextField("", text: text, axis: .vertical)
                .overlay(alignment:  .topLeading) {
                    if text.wrappedValue.isEmpty {
                        Text(placeHolder)
                            .foregroundStyle(.gray.opacity(0.5))
                            .frame(height: 100, alignment: .topLeading)
                            .lineLimit(nil)
                            .allowsHitTesting(false)
                    }
                }
                .padding(16)
                .padding(.bottom, 60)
                .font(.subheadline)
                .kerning(0.5)
                .lineSpacing(4)
                .textInputAutocapitalization(.never)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.white)
                }
                .foregroundStyle(.customTextColorBlack)
        }
    }
}

// YouTube動画を添付表示するフィールド
extension CreateRecruitmentView {
    private func youtubeFormField(title: String, url: Binding<String>) -> some View {
        VStack(spacing: 16) {
            // YouTube
            singleLineTextFormField(l10n.placeHolderYoutubeURL,
                                    title: l10n.youtubeTitle,
                                    text: $vm.inputYoutubeURL
            )
            if !url.wrappedValue.isEmpty {
                // TODO: 入力されたurlが有効だった場合、リンク先の動画を表示
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.customAccentYellow)
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.gray).opacity(0.2))
    }
}

// ジャンル選択カプセルボタン
extension CreateRecruitmentView {
    @ViewBuilder
    private func musicGenreSelectFormField(title: String,
                                           genres: [MusicGenre],
                                           highlightedGenres: Binding<[MusicGenre]>
    ) -> some View {
        VStack(alignment: .leading) {
            CustomText("▫️\(title)", .customTextColorWhite).font(.headline)
            MusicGenresCapsuleView(genres: genres,
                                   highlightedGenres: highlightedGenres,
                                   isEditing: true
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension CreateRecruitmentView {
    @ViewBuilder
    private func wantedPartsSelectionForm(title: String, parts: [Part]) -> some View {
        let iconSize: CGFloat = 120

        VStack(alignment: .leading) {
            HStack {
                CustomText("\(l10n.wantedPartsTitle)：", .customTextColorWhite).font(.headline)
                Button("選択") {
                    vm.isShowSelectPartSheet.toggle()
                }
                .buttonStyle(.borderedProminent)
                .font(.caption.bold())
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    if parts.contains(where: { $0.isWanted == true }) {
                        ForEach(parts) { part in
                            if part.isWanted {
                                VStack(spacing: 10) {
                                    // TODO: 性別指定なしの場合は、currentUserの性別を使う
                                    Image(part.iconName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: iconSize, height: iconSize)
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
                    } else {
                        // TODO: 募集パートなしの場合のアイコン
                        VStack(spacing: 10) {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: iconSize, height: iconSize)
                                .foregroundStyle(.white.gradient)
                                .shadow(radius: 3)
                                .overlay {
                                    Image(systemName: Constants.Symbols.questionmark)
                                        .font(.title)
                                        .foregroundStyle(.gray)
                                }
                            Text("未選択")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
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

// 写真選択ビュー
extension CreateRecruitmentView {
    @ViewBuilder
    private func selectImagesFormField(title: String, images: [ImageData], selection selectionImagesData: [UIImage]) -> some View {
        VStack(alignment: .leading) {
            CustomText("▫️\(title)", .customTextColorWhite)
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    // すでに保存されている写真
                    ForEach(images, id: \.self.path) { image in
                        AsyncImage(url: image.url)
                            .scaledToFit()
                            .frame(width: 200, height: 150)
                            .onTapGesture { vm.isShowPicker = true }
                    }
                    // 新しく選択追加された写真
                    ForEach(selectionImagesData, id: \.self) { uiImage in
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .onTapGesture {
                                vm.isShowPicker = true
                            }
                    }
                    // 写真追加ボタン
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 200, height: 150)
                            .foregroundStyle(.gray.gradient)
                        Image(systemName: Constants.Symbols.photo_on_rectangle_angled)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.black.opacity(0.3))
                            .overlay(alignment: .topTrailing) {
                                Image(systemName: Constants.Symbols.plus_circle_fill)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.black.opacity(0.4))
                                    .offset(x: 15, y: -5)
                            }
                    }
                    .onTapGesture { vm.isShowPicker = true }
                }
                .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    CreateRecruitmentView()
}
