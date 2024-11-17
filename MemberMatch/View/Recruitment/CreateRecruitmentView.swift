//
//  RecruitmentEditView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/01.
//

import PhotosUI
import SwiftUI

struct CreateRecruitmentView: View {
    var existingData: Recruitment?
    @EnvironmentObject var router: Router
    @EnvironmentObject var userManager: UserManager

    @Environment(\.presentationMode) var presentationMode

    @StateObject private var vm = CreateRecruitmentViewModel()

    @State private var toastMessage: String = ""
    @State private var toastDismissTask: Task<Void, Never>?

    private let l10n = Constants.Strings.self

    var body: some View {
        VStack {
            TabTopBarView(
                existingData != nil ? l10n.editRecruitmentPageTitle : l10n.createRecruitmentPageTitle,
                leftToolbarItems: {
                    Image(systemName: Constants.Symbols.chevron_backward)
                        .foregroundStyle(.gray)
                        .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                        .background(Circle().foregroundStyle(.white))
                        .onTapGesture { presentationMode.wrappedValue.dismiss() }
                },
                rightToolbarItems: {
                    editCompleteButton(existingData != nil
                                       ? l10n.editRecruitmentToolbarButtonText
                                       : l10n.postRecruitmentToolbarButtonText
                    ) {
                        onPressedCompleteButton(existingData: existingData)
                    }
                }
            )

            ScrollView {
                VStack(spacing: 40) {
                    // タイトル
                    singleLineTextFormField(l10n.placeHolderTitle,
                                            title: l10n.recruitmentTitleTitle,
                                            text: $vm.inputTitle,
                                            validate: InputFieldValidator.validateTitle(vm.inputTitle)
                    )
                    // 写真
                    selectImagesFormField(title: l10n.photoTitle,
                                          images: vm.inputImages,
                                          selection: vm.selectionImages
                    )
                    // 募集パート
                    wantedPartsSelectionForm(title: l10n.wantedPartsTitle,
                                             parts: vm.inputWantedParts
                    )
                    // 募集詳細
                    multiLineTextFormField(l10n.placeHolderDescription,
                                           title: l10n.recruitmentDescTitle,
                                           text: $vm.inputDescription,
                                           validate: InputFieldValidator.validateDescription(vm.inputDescription)
                    )
                    // ジャンル
                    musicGenreSelectFormField(title: l10n.musicGenreTitle,
                                              genres: MusicGenre.allCases,
                                              highlightedGenres: $vm.inputMusicGenre
                    )
                    // 活動頻度
                    singleLineTextFormField(l10n.placeHolderFrequency,
                                            title: l10n.frequencyTitle,
                                            text: $vm.inputFrequency,
                                            validate: InputFieldValidator.validateFrequency(vm.inputFrequency)
                    )
                    // 活動拠点
                    singleLineTextFormField(l10n.placeHolderRehearsalLocation,
                                            title: l10n.locationTitle,
                                            text: $vm.inputRehearsalLocation,
                                            validate: InputFieldValidator.validateRehearsalLocation(
                                                vm.inputRehearsalLocation
                                            )
                    )
                    // その他/備考
                    multiLineTextFormField(l10n.placeHolderAdditionalInfo,
                                           title: l10n.additionalInfoTitle,
                                           text: $vm.inputAdditionalInfo,
                                           validate: InputFieldValidator.validateAdditionalInfo(vm.inputAdditionalInfo)
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
                                                text: $vm.inputTwitterURL,
                                                validate: InputFieldValidator.validateTwitterURL(vm.inputTwitterURL)
                        )
                        // Instagram
                        singleLineTextFormField(l10n.placeHolderInstagramURL,
                                                title: l10n.instagramTitle,
                                                text: $vm.inputInstagramURL,
                                                validate: InputFieldValidator.validateInstagramURL(vm.inputInstagramURL)
                        )
                        // Facebook
                        singleLineTextFormField(l10n.placeHolderFacebookURL,
                                                title: l10n.facebookTitle,
                                                text: $vm.inputFacebookURL,
                                                validate: InputFieldValidator.validateFacebookURL(vm.inputFacebookURL)
                        )
                    }
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.gray).opacity(0.2))
                } // VStack
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
            } // ScrollView
            .overlay {
                if vm.showToast {
                    VStack {
                        ToastView(message: toastMessage,
                                  backGroundColor: Color.red,
                                  foregroundColor: Color.white
                        )
                        Spacer()
                    }
                }
            }
        }
        .gradientBackground()
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
        .onAppear {
            if let existingData {
                // 投稿内容の編集の場合は、各フィールドに内容をセット
                vm.setEditData(existingData)
            }
        }
    }

    private func onPressedCompleteButton(existingData: Recruitment?) {
        guard vm.isValidSubmission() else {
            showToastMessage(Constants.Strings.invalidCreateRecruitmentToastMessage)
            return
        }
        if let existingData {
            vm.editRecruitment(existingData: existingData)
        } else {
            vm.postRecruitment()
        }

        presentationMode.wrappedValue.dismiss()
    }

    private func showToastMessage(_ message: String) {
        // 既にトースト表示中の場合は処理しない
        if vm.showToast { return }

        toastMessage = message
        withAnimation { vm.showToast = true }
        HapticFeedback.shared.trigger(.notification(type: .error))

        // 一定時間後にトーストを非表示にする処理を開始
        toastDismissTask = Task {
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2秒
            withAnimation { vm.showToast = false }
        }
    }

    @ViewBuilder
    private func editCompleteButton(_ text: String, _ action: @escaping () -> Void) -> some View {
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
    private func singleLineTextFormField(_ placeHolder: String,
                                         title: String,
                                         text: Binding<String>,
                                         validate: ValidateStatus) -> some View {
        VStack(alignment: .leading) {
            HStack {
                CustomText("▫️\(title)", .customTextColorWhite)
                    .font(.headline)

                if text.wrappedValue.isEmpty {
                    EmptyView()
                } else if validate == .success {
                    Image(systemName: Constants.Symbols.checkmark_seal_fill)
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: Constants.Symbols.xmark_seal_fill)
                        .foregroundStyle(.red)
                    Text(validate.description)
                        .font(.caption)
                        .foregroundStyle(.red)
                }

                if validate == .success && URLNavigator.isExternalLink(urlString: text.wrappedValue) {
                    Button {
                        URLNavigator.openURL(text.wrappedValue)
                    } label: {
                        Image(systemName: Constants.Symbols.link_circle_fill)
                            .foregroundStyle(.customAccentYellow)
                    }
                }
            }

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
                        .overlay {
                            if validate != .success {
                                Color.red.opacity(0.5)
                            }
                        }
                }
                .foregroundStyle(.black)
        }
    }
}

// 複数行、改行が可能なテキストフィールド
extension CreateRecruitmentView {
    @ViewBuilder
    private func multiLineTextFormField(_ placeHolder: String,
                                        title: String,
                                        text: Binding<String>,
                                        validate: ValidateStatus) -> some View {
        VStack(alignment: .leading) {
            HStack {
                CustomText("▫️\(title)", .customTextColorWhite)
                    .autocapitalization(.none)
                    .font(.headline)

                if text.wrappedValue.isEmpty {
                    EmptyView()
                } else if validate == .success {
                    Image(systemName: Constants.Symbols.checkmark_seal_fill)
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: Constants.Symbols.xmark_seal_fill)
                        .foregroundStyle(.red)
                    Text(validate.description)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
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
                        .overlay {
                            if validate != .success {
                                Color.red.opacity(0.5)
                            }
                        }
                }
                .foregroundStyle(.black)
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
                                    text: $vm.inputYoutubeURL,
                                    validate: InputFieldValidator.validateYouTubeURL(url.wrappedValue)
            )
            CustomYTView(urlString: url.wrappedValue)
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
        var isWantedParts: [Part] {
            parts.filter { $0.isWanted == true }
        }

        VStack(alignment: .leading) {
            HStack {
                CustomText("\(l10n.wantedPartsTitle)：", .customTextColorWhite).font(.headline)
                Button(l10n.partSelectButtonText) {
                    vm.isShowSelectPartSheet.toggle()
                }
                .buttonStyle(.borderedProminent)
                .font(.caption.bold())
            }

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
    private func selectImagesFormField(title: String,
                                       images: [ImageData],
                                       selection selectionImagesData: [UIImage]
    ) -> some View {
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
