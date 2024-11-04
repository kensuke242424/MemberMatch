//
//  CreateRecruitmentViewModel.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/02.
//

import PhotosUI
import SwiftUI

class CreateRecruitmentViewModel: ObservableObject {
    // input Properties
    @Published var inputTitle: String = ""
    @Published var inputDescription: String = ""
    @Published var inputPolicy: Policy = .nothing
    @Published var inputFrequency: String = ""
    @Published var inputMusicGenre: [MusicGenre] = []
    @Published var inputWantedParts: [Part] = Part.getAllContent()
    @Published var inputImages: [ImageData] = []
    @Published var inputRehearsalLocation: String = ""
    @Published var inputYoutubeURL: String = ""
    @Published var inputTwitterURL: String = ""
    @Published var inputInstagramURL: String = ""
    @Published var inputFacebookURL: String = ""
    @Published var inputAdditionalInfo: String = ""

    // View Properties
    @Published var isShowPicker: Bool = false
    @Published var isShowSelectPartSheet: Bool = false
    @Published var selectedImage: UIImage?
    @Published var selectionImages: [UIImage] = []

    func setEditData(_ editData: Recruitment) {
        self.inputTitle = editData.title ?? ""
        self.inputDescription = editData.description ?? ""
        self.inputPolicy = editData.policy ?? .nothing
        self.inputFrequency = editData.frequency ?? ""
        self.inputMusicGenre = editData.genre ?? []
        self.inputWantedParts = editData.wantedParts
        self.inputImages = editData.images ?? []
        self.inputRehearsalLocation = editData.rehearsalLocation ?? ""
        self.inputAdditionalInfo = editData.additionalInfo ?? ""
        self.inputYoutubeURL = editData.youtubeVideoURL?.first ?? ""
        self.inputTwitterURL = editData.author.socialMediaLinks.twitter ?? ""
        self.inputInstagramURL = editData.author.socialMediaLinks.instagram ?? ""
        self.inputFacebookURL = editData.author.socialMediaLinks.facebook ?? ""
    }

    func createRecruitment() {
        //TODO: Model経由で募集を作成
    }

    func editRecruitment(editData: Recruitment) {
        //TODO: Model経由で募集を更新
    }

    /// 各入力値のバリデーションが通っているかをチェックするメソッド。
    func isValidSubmission() -> Bool {
        var result: Bool = true

        if InputFieldValidator.validateTitle(inputTitle) != .success {
            result = false
        }
        if InputFieldValidator.validateDescription(inputDescription) != .success {
            result = false
        }
        if InputFieldValidator.validateFrequency(inputFrequency) != .success {
            result = false
        }
        if InputFieldValidator.validateRehearsalLocation(inputRehearsalLocation) != .success {
            result = false
        }
        if InputFieldValidator.validateAdditionalInfo(inputAdditionalInfo) != .success {
            result = false
        }
        if InputFieldValidator.validateYouTubeURL(inputYoutubeURL) != .success {
            result = false
        }
        if InputFieldValidator.validateTwitterURL(inputTwitterURL) != .success {
            result = false
        }
        if InputFieldValidator.validateInstagramURL(inputInstagramURL) != .success {
            result = false
        }
        if InputFieldValidator.validateFacebookURL(inputFacebookURL) != .success {
            result = false
        }

        return result
    }
}
