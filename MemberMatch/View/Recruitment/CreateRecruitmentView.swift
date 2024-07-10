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

    @Environment(\.presentationMode)
    var presentationMode

    @StateObject private var vm = CreateRecruitmentViewModel()

    var body: some View {
        VStack {
            TabTopBarView(
                editData == nil ?
                Constants.Strings.createRecruitmentPageTitle : Constants.Strings.editRecruitmentPageTitle,
                leftToolbarItems: {
                    Image(systemName: Constants.Symbols.chevron_backward)
                        .foregroundStyle(.gray)
                        .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                        .background(Circle().foregroundStyle(.white))
                        .onTapGesture { presentationMode.wrappedValue.dismiss() }
                },
                rightToolbarItems: {
                    Button(Constants.Strings.draftButtonText) {
                        // TODO: 下書き保存処理
                    }
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background {
                        Capsule().foregroundStyle(.white.gradient)
                    }
                }
            )

            ScrollView {
                VStack(spacing: 40) {
                    // タイトル
                    singleLineTextFormField(Constants.Strings.placeHolderTitle,
                                            title: Constants.Strings.recruitmentTitleTitle,
                                            text: $vm.inputTitle
                    )
                    // 募集詳細
                    multiLineTextFormField(Constants.Strings.placeHolderDescription,
                                           title: Constants.Strings.recruitmentDescTitle,
                                           text: $vm.inputDescription
                    )
                    // 写真
                    selectImagesFormField(title: Constants.Strings.photoTitle,
                                          images: vm.inputImages,
                                          selection: vm.selectionImages
                    )
                    // ジャンル
                    musicGenreSelectFormField(title: Constants.Strings.musicGenreTitle,
                                              genres: MusicGenre.allCases,
                                              highlightedGenres: $vm.inputMusicGenre
                    )
                    // 活動頻度
                    singleLineTextFormField(Constants.Strings.placeHolderFrequency,
                                            title: Constants.Strings.frequencyTitle,
                                            text: $vm.inputFrequency
                    )
                    // 活動拠点
                    singleLineTextFormField(Constants.Strings.placeHolderRehearsalLocation,
                                            title: Constants.Strings.locationTitle,
                                            text: $vm.inputRehearsalLocation
                    )
                    // その他/備考
                    multiLineTextFormField(Constants.Strings.placeHolderAdditionalInfo,
                                           title: Constants.Strings.additionalInfoTitle,
                                           text: $vm.inputAdditionalInfo
                    )
                    // Youtube
                    youtubeFormField(title: Constants.Strings.youtubeTitle,
                                     url: $vm.inputYoutubeURL
                    )
                    // SNS URLs
                    VStack(spacing: 16) {
                        // X(Twitter)
                        singleLineTextFormField(Constants.Strings.placeHolderTwitterURL,
                                                title: Constants.Strings.twitterTitle,
                                                text: $vm.inputTwitterURL
                        )
                        // Instagram
                        singleLineTextFormField(Constants.Strings.placeHolderInstagramURL,
                                                title: Constants.Strings.instagramTitle,
                                                text: $vm.inputInstagramURL
                        )
                        // Facebook
                        singleLineTextFormField(Constants.Strings.placeHolderFacebookURL,
                                                title: Constants.Strings.facebookTitle,
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

extension CreateRecruitmentView {
    private func youtubeFormField(title: String, url: Binding<String>) -> some View {
        VStack(spacing: 16) {
            // YouTube
            singleLineTextFormField(Constants.Strings.placeHolderYoutubeURL,
                                    title: Constants.Strings.youtubeTitle,
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
                            .onTapGesture {
                                // TODO: 仮でピッカー表示。選択画像をセットし編集画面を開けるようにする
                                vm.startPickerImage()
                            }
                    }
                    // 新しく選択追加された写真
                    ForEach(selectionImagesData, id: \.self) { uiImage in
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .onTapGesture {
                                // TODO: 仮でピッカー表示。選択画像をセットし編集画面を開けるようにする
                                vm.startPickerImage()
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
                    .onTapGesture {
                        vm.isShowPicker = true
                    }
                }
                .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    CreateRecruitmentView()
}
