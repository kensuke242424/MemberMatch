/*
 id: ユーザーの一意な識別子。
 name: ユーザーの名前。
 email: 連絡先のメールアドレス。
 selfIntroduction: 自己紹介。
 prefecture: 活動場所。
 instrument: ユーザーが演奏する楽器。
 experienceLevel: スキルレベル（例：初心者、中級者、上級者）。
 preferredGenre: 好みの音楽ジャンル。
 policy: 活動方針。
 profileImageURL: 任意のプロフィール画像のURL。
 bio: 短い自己紹介文や説明。
 */

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: String
    var name: String?
    var gender: Gender
    var email: String?
    var prefecture: Prefecture?
    var selfIntroduction: String?
    var instrument: [Instrument]?
    var skillLevel: SkillLevel?
    var commitmentLevel: CommitmentLevel?
    var preferredGenre: [MusicGenre]?
    var policy: Policy?
    var profileImageURL: URL?
    var bio: String?

    init(
        id: String = UUID().uuidString,
        name: String?,
        gender: Gender,
        email: String?,
        prefecture: Prefecture?,
        selfIntroduction: String?,
        instrument: [Instrument]?,
        skillLevel: SkillLevel?,
        preferredGenre: [MusicGenre]?,
        policy: Policy?,
        profileImageURL: URL?,
        bio: String?
    ) {
        self.id = id
        self.name = name
        self.gender = gender
        self.email = email
        self.prefecture = prefecture
        self.selfIntroduction = selfIntroduction
        self.instrument = instrument
        self.skillLevel = skillLevel
        self.preferredGenre = preferredGenre
        self.policy = policy
        self.profileImageURL = profileImageURL
        self.bio = bio
    }
}

let mockUser = User(
    name: "Arris",
    gender: Gender.female,
    email: "john.doe@example.com",
    prefecture: .tokyo,
    selfIntroduction: "",
    instrument: [.guitar, .vocal],
    skillLevel: .expert,
    preferredGenre: [.rock, .jazz],
    policy: .professional,
    profileImageURL: URL(string: "https://example.com/images/john.jpg"),
    bio: "ギターと歌をこよなく愛するミュージシャン。ロックとジャズの融合に情熱を注いでいます。"
)
