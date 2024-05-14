/*
 id: ユーザーの一意な識別子。
 name: ユーザーの名前。
 email: 連絡先のメールアドレス。
 instrument: ユーザーが演奏する楽器。
 experienceLevel: スキルレベル（例：初心者、中級者、上級者）。
 preferredGenre: 好みの音楽ジャンル。
 profileImageURL: 任意のプロフィール画像のURL。
 bio: 短い自己紹介文や説明。
 */

import Foundation

struct User: Identifiable,Hashable, Codable {
    let id: String
    var name: String?
    var email: String?
    var prefecture: Prefecture?
    var instrument: [Instrument]?
    var skillLevel: SkillLevel?
    var commitmentLevel: CommitmentLevel?
    var preferredGenre: [MusicGenre]?
    var profileImageURL: URL?
    var bio: String?

    init(
        id: String = UUID().uuidString,
        name: String?,
        email: String?,
        prefecture: Prefecture?,
        instrument: [Instrument]?,
        skillLevel: SkillLevel?,
        preferredGenre: [MusicGenre]?,
        profileImageURL: URL?,
        bio: String?
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.prefecture = prefecture
        self.instrument = instrument
        self.skillLevel = skillLevel
        self.preferredGenre = preferredGenre
        self.profileImageURL = profileImageURL
        self.bio = bio
    }
}

let mockUser = User(
    name: "John Doe",
    email: "john.doe@example.com",
    prefecture: .aichi,
    instrument: [.guitar, .vocal],
    skillLevel: .intermediate,
    preferredGenre: [.rock, .jazz],
    profileImageURL: URL(string: "https://example.com/images/john.jpg"),
    bio: "ギターと歌をこよなく愛するミュージシャン。ロックとジャズの融合に情熱を注いでいます。"
)
