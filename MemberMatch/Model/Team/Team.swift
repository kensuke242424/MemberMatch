import Foundation

/*
 id: バンドの一意な識別子。
 name: バンド名。
 genre: バンドが活動する音楽ジャンル。
 foundedDate: バンドが結成された日付。
 members: バンドメンバーのリスト。ここではUser構造体の配列を使用します。
 biography: バンドの伝記や紹介文。
 contactEmail: バンドへの連絡用メールアドレス。
 websiteURL: バンドの公式ウェブサイトのURL（あれば）。
 socialMediaLinks: バンドのソーシャルメディアアカウントへのリンク。キーとしてプラットフォーム名（例：「Facebook」や「Instagram」）と、それに対応するURLを保持します。
 logoURL: バンドのロゴ画像のURL（あれば）。
 twitterAccount: Twitterのプロフィールページへのリンク。
 instagramAccount: Instagramのプロフィールページへのリンク。
 youtubeVideoURL: バンドに関連するYouTube動画のURL。
 */

struct Team: Identifiable, Codable, Hashable {
    let id: String
    var name: String?
    var genre: [MusicGenre]?
    var prefecture: Prefecture?
    var foundedDate: Date?
    var members: [User]?  // Userモデルはバンドメンバーの情報を持つ構造体
    var bio: String?
    var contactEmail: String?
    var websiteURL: URL?
    var socialMediaLinks: [String: URL]?  // ソーシャルメディアのリンクはキーとURLで管理
    var logoURL: URL?  // バンドのロゴ画像のURL
    var twitterAccount: URL?  // TwitterアカウントのURL
    var instagramAccount: URL?  // InstagramアカウントのURL
    var youtubeVideoURL: [URL]?  // YouTube動画のURL

    init(
        id: String = UUID().uuidString,
        name: String?,
        genre: [MusicGenre]?,
        prefecture: Prefecture?,
        foundedDate: Date?,
        members: [User]?,
        bio: String?,
        contactEmail: String?,
        websiteURL: URL?,
        socialMediaLinks: [String: URL]?,
        logoURL: URL?,
        twitterAccount: URL?,
        instagramAccount: URL?,
        youtubeVideoURL: [URL]?
    ) {
        self.id = id
        self.name = name
        self.genre = genre
        self.prefecture = prefecture
        self.foundedDate = foundedDate
        self.members = members
        self.bio = bio
        self.contactEmail = contactEmail
        self.websiteURL = websiteURL
        self.socialMediaLinks = socialMediaLinks
        self.logoURL = logoURL
        self.twitterAccount = twitterAccount
        self.instagramAccount = instagramAccount
        self.youtubeVideoURL = youtubeVideoURL
    }
}

// Team モデルのモックデータを作成
let mockTeam = Team(
    id: UUID().uuidString,
    name: "Echoes of the Future",
    genre: [.rock, .electronic],
    prefecture: .osaka,
    foundedDate: Date(timeIntervalSince1970: 946684800), // 2000年1月1日
    members: [mockUser],
    bio: "「Echoes of the Future」はエレクトロニック・ロックを融合させたバンドで、彼らのエネルギッシュなパフォーマンスと深い歌詞で知られています。",
    contactEmail: "contact@echoesfuture.com",
    websiteURL: URL(string: "https://www.echoesfuture.com"),
    socialMediaLinks: [
        "Twitter": URL(string: "https://twitter.com/echoesfuture")!,
        "Instagram": URL(string: "https://instagram.com/echoesfuture")!
    ],
    logoURL: URL(string: "https://www.echoesfuture.com/logo.png"),
    twitterAccount: URL(string: "https://twitter.com/echoesfuture"),
    instagramAccount: URL(string: "https://instagram.com/echoesfuture"),
    youtubeVideoURL: [
        URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!
    ]
)
