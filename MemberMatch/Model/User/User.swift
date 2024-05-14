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

struct User: Identifiable, Codable {
    let id: String
    var name: String
    var email: String
    var instrument: String
    var experienceLevel: String
    var preferredGenre: String
    var profileImageURL: URL?
    var bio: String

    init(
        id: String = UUID().uuidString,
        name: String,
        email: String,
        instrument: String,
        experienceLevel: String = "Beginner",
        preferredGenre: String = "All",
        profileImageURL: URL? = nil,
        bio: String = ""
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.instrument = instrument
        self.experienceLevel = experienceLevel
        self.preferredGenre = preferredGenre
        self.profileImageURL = profileImageURL
        self.bio = bio
    }
}

let exampleUsers = [
    User(
        id: UUID().uuidString,
        name: "田中 太郎",
        email: "taro.tanaka@example.com",
        instrument: "ギター",
        experienceLevel: "中級者",
        preferredGenre: "ロック",
        profileImageURL: URL(string: "https://example.com/profile_images/tanaka.jpg"),
        bio: "10年以上の演奏経験があります。現在はバンドでリードギターを担当しています。"
    ),
    User(
        id: UUID().uuidString,
        name: "山田 花子",
        email: "hanako.yamada@example.com",
        instrument: "ボーカル",
        experienceLevel: "上級者",
        preferredGenre: "ジャズ",
        profileImageURL: URL(string: "https://example.com/profile_images/yamada.jpg"),
        bio: "ジャズバンドでの活動経験が豊富です。幅広いジャンルで歌える多才なボーカリストです。"
    ),
    User(
        id: UUID().uuidString,
        name: "佐藤 健",
        email: "ken.sato@example.com",
        instrument: "ベース",
        experienceLevel: "初心者",
        preferredGenre: "ポップス",
        profileImageURL: URL(string: "https://example.com/profile_images/sato.jpg"),
        bio: "最近バンド活動を始めたばかりです。ポップスが得意で、ベースのリズム感には自信があります。"
    ),
    User(
        id: UUID().uuidString,
        name: "鈴木 一郎",
        email: "ichiro.suzuki@example.com",
        instrument: "ドラム",
        experienceLevel: "中級者",
        preferredGenre: "ヒップホップ",
        profileImageURL: URL(string: "https://example.com/profile_images/suzuki.jpg"),
        bio: "ヒップホップバンドでドラムを担当しています。力強いビートを生み出すことが得意です。"
    )
]
