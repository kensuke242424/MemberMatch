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
    var socialMediaLinks: SocialMediaLinks

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
        bio: String?,
        socialMediaLinks: SocialMediaLinks
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
        self.socialMediaLinks = socialMediaLinks
    }
}

let guestUser = User(
    name: "ゲスト",
    gender: Gender.unknown,
    email: "guest@example.com",
    prefecture: .tokyo,
    selfIntroduction: "",
    instrument: [],
    skillLevel: .none,
    preferredGenre: [],
    policy: .none,
    profileImageURL: URL(string: ""),
    bio: "",
    socialMediaLinks: SocialMediaLinks()
)

let mockUser = User(
    name: "モック沢あきこ",
    gender: Gender.female,
    email: "john.doe@example.com",
    prefecture: .tokyo,
    selfIntroduction: "",
    instrument: [.guitar, .vocal],
    skillLevel: .expert,
    preferredGenre: [.rock, .jazz],
    policy: .professional,
    profileImageURL: URL(string: "https://example.com/images/john.jpg"),
    bio: "ギターと歌をこよなく愛するミュージシャン。ロックとジャズの融合に情熱を注いでいます。",
    socialMediaLinks: SocialMediaLinks(
        twitter: URL(string: "https://twitter.com/echoesfuture"),
        instagram: URL(string: "https://instagram.com/echoesfuture"),
        facebook: nil
    )
)

let mockUser2 = User(
    name: "モック原健太",
    gender: Gender.male,
    email: "kenta.music@example.com",
    prefecture: .osaka,
    selfIntroduction: "初心者ですが、一緒に音楽を楽しみたいです！",
    instrument: [.bass, .drums],
    skillLevel: .beginner,
    preferredGenre: [.pop],
    policy: .hobby,
    profileImageURL: URL(string: "https://example.com/images/kenta.jpg"),
    bio: "ポップとファンクが大好きな初心者ミュージシャン。楽しく音楽を演奏することを大切にしています。",
    socialMediaLinks: SocialMediaLinks(
        twitter: URL(string: "https://twitter.com/music_kenta"),
        instagram: URL(string: "https://instagram.com/music_kenta"),
        facebook: URL(string: "https://facebook.com/music.kenta")
    )
)
