//
//  CreateRecruitmentViewModel.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/02.
//

import Foundation

class CreateRecruitmentViewModel: ObservableObject {
    // input Properties
    @Published var inputTitle: String = ""
    @Published var inputDescription: String = ""
    @Published var inputPolicy: Policy = .nothing
    @Published var inputFrequency: String = ""
    @Published var inputMusicGenre: [MusicGenre] = []
    @Published var inputWantedParts: [Part] = []
    @Published var inputImages: [ImageData] = []
    @Published var inputRehearsalLocation: String = ""
    @Published var inputAdditionalInfo: String = ""

    func setEditData(_ editData: Recruitment) {
        self.inputTitle = editData.title ?? ""
        self.inputDescription = editData.description ?? ""
        self.inputPolicy = editData.policy ?? .nothing
        self.inputFrequency = editData.frequency ?? ""
        self.inputMusicGenre = editData.genre ?? []
        self.inputWantedParts = editData.wantedParts ?? []
        self.inputImages = editData.images ?? []
        self.inputRehearsalLocation = editData.rehearsalLocation ?? ""
        self.inputAdditionalInfo = editData.additionalInfo ?? ""
    }
}
