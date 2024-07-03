//
//  RecruitmentEditView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/01.
//

import SwiftUI

struct CreateRecruitmentView: View {
    var editData: Recruitment?
    @EnvironmentObject var router: Router
    @EnvironmentObject var userManager: UserManager

    @Environment(\.presentationMode)
    var presentationMode

    @StateObject private var vm = CreateRecruitmentViewModel()

    // 募集の内容入力フィールド専用のフォーカス制御
    @FocusState var descriptionFocused: Bool?

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
                    // ピン留めボタン
                    Image(systemName: Constants.Symbols.pin_fill)
                        .foregroundStyle(.gray)
                        .frame(width: Constants.toolBarItemSize, height: Constants.toolBarItemSize)
                        .background(Circle().foregroundStyle(.white))
                }
            )

            ScrollView {
                VStack(spacing: 40) {
                    // タイトル
                    singleLineTextFormField(Constants.Strings.placeHolderTitle,
                                            title: Constants.Strings.recruitmentTitleTitle,
                                            text: $vm.inputTitle
                    )
                    // ジャンル
                    musicGenreSelectForm(title: Constants.Strings.musicGenreTitle,
                                         genres: MusicGenre.allCases,
                                         highlightedGenres: $vm.inputMusicGenre,
                                         isEditing: true
                    )
                    // 募集詳細
                    multiLineTextFormField(Constants.Strings.placeHolderDescription,
                                           title: Constants.Strings.recruitmentDescTitle,
                                           text: $vm.inputDescription
                    )
                }
                .padding()
            }
        }
        .gradientBackground()
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
        .onAppear {
            if let editData {
                vm.setEditData(editData)
            }
        }
    }
}

extension CreateRecruitmentView {
    @ViewBuilder
    private func singleLineTextFormField(_ placeHolder: String, title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            CustomText("▫️\(title)", .customTextColorWhite)
                .font(.headline)

            TextField("", text: text)
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

extension CreateRecruitmentView {
    @ViewBuilder
    private func multiLineTextFormField(_ placeHolder: String, title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            CustomText("▫️\(title)", .customTextColorWhite)
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
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button(Constants.Strings.hideKeyboardToolBarButtonText) {
                            hideKeyboard()
                        }
                        .foregroundStyle(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background {
                            Capsule().foregroundStyle(.blue.gradient)
                        }
                    }
                }
                .focused($descriptionFocused, equals: true)
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
    @ViewBuilder
    private func musicGenreSelectForm(title: String,
                                      genres: [MusicGenre],
                                      highlightedGenres: Binding<[MusicGenre]>,
                                      isEditing: Bool
    ) -> some View {
        VStack(alignment: .leading) {
            CustomText("▫️\(title)", .customTextColorWhite).font(.headline)
            MusicGenresCapsuleView(genres: genres,
                                   highlightedGenres: highlightedGenres,
                                   isEditing: isEditing
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CreateRecruitmentView()
}
