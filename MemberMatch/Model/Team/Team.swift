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
 socialMediaLinks: SNSリンク。
 */

struct Team: Identifiable, Codable, Hashable {
    let id: String
    var name: String?
    var genre: [MusicGenre]?
    var prefecture: Prefecture?
    var foundedDate: Date?
    var members: [User]?
    var bio: String?
    var contactEmail: String?
    var websiteURL: String?
    var logoURL: String?
    var youtubeVideoURL: [String]?
    var socialMediaLinks: SocialMediaLinks

    init(
        id: String = UUID().uuidString,
        name: String?,
        genre: [MusicGenre]?,
        prefecture: Prefecture?,
        foundedDate: Date?,
        members: [User]?,
        bio: String?,
        contactEmail: String?,
        websiteURL: String?,
        logoURL: String?,
        twitterAccount: String?,
        instagramAccount: String?,
        youtubeVideoURL: [String]?,
        socialMediaLinks: SocialMediaLinks
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
        self.logoURL = logoURL
        self.youtubeVideoURL = youtubeVideoURL
        self.socialMediaLinks = socialMediaLinks
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
    websiteURL: "https://www.echoesfuture.com",
    logoURL: "https://www.echoesfuture.com/logo.png",
    twitterAccount: "https://twitter.com/echoesfuture",
    instagramAccount: "https://instagram.com/echoesfuture",
    youtubeVideoURL: [
        "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    ],
    socialMediaLinks: SocialMediaLinks(
        twitter: "https://twitter.com/echoesfuture",
        instagram: "https://instagram.com/echoesfuture",
        facebook: nil
    )
)
