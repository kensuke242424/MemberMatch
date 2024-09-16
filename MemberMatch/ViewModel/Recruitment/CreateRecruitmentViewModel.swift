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
    }

    func createRecruitment() {
        //TODO: Model経由で募集を作成
    }

    func editRecruitment(editData: Recruitment) {
        //TODO: Model経由で募集を更新
    }
}
