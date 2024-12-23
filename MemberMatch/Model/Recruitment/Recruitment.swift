/*
 id: 募集情報を一意に識別するためのID。
 postedDate: 募集が投稿された日時。
 deadline: 応募締切日。
 user: 投稿したユーザー。
 title: 募集のタイトル。
 description: 募集内容の詳細な説明。
 policy: 募集方針。
 frequency: 活動頻度。
 genre: ジャンル。
 location: 募集の場所またはリモートワークの可能性。
 category: 募集が属するカテゴリ（例：テクノロジー、マーケティングなど）。
 additionalInfo: 追加情報（任意）。
 */

import Foundation

struct Recruitment: Identifiable, Hashable {
    let id: String
    let postedDate: Date
    let author: User
    var favorite: Int
    var title: String?
    var description: String?
    var images: [ImageData]?
    var policy: Policy?
    var frequency: String?
    var genre: [MusicGenre]?
    var wantedParts: [Part]
    var rehearsalLocation: String?
    var additionalInfo: String?
    var youtubeVideoURL: [String]?  // YouTube動画のURL

    init(
        id: String = UUID().uuidString,
        postedDate: Date = Date(),
        author: User,
        favorite: Int = 0,
        title: String,
        description: String,
        images: [ImageData]? = [],
        policy: Policy?,
        frequency: String? = nil,
        genre: [MusicGenre] = [],
        wantedParts: [Part] = Part.getAllContent(),
        rehearsalLocation: String,
        additionalInfo: String? = nil,
        youtubeVideoURL: [String]? = nil
    ) {
        self.id = id
        self.postedDate = postedDate
        self.author = author
        self.favorite = favorite
        self.title = title
        self.description = description
        self.images = images
        self.policy = policy
        self.genre = genre
        self.frequency = frequency
        self.wantedParts = wantedParts
        self.rehearsalLocation = rehearsalLocation
        self.additionalInfo = additionalInfo
        self.youtubeVideoURL = youtubeVideoURL
    }

    var isWantedPart: Bool {
        return wantedParts.contains(where: { $0.isWanted == true })
    }
}

// ダミーデータ
let exampleRecruitments = [
    Recruitment(
        id: UUID().uuidString,
        postedDate: Calendar.current.date(byAdding: .day, value: -10, to: Date()) ?? Date(),
        author: mockUser,
        favorite: 40,
        title: "POPバンドのメンバー大募集！ガチでやろうぜ！",
        description:
"""
ポップスバンドで経験豊富なバンドメンバーを探しています。ポップスバンドで経験豊富なバンドメンバーを探しています。
ポップスバンドで経験豊富なバンドメンバーを探しています。ポップスバンドで経験豊富なバンドメンバーを探しています。
""",
        images: [
            .init(url: "https://via.placeholder.com/600x400.png?text=Sample+Image+1", path: ""),
            .init(url: "https://via.placeholder.com/600x400.png?text=Sample+Image+2", path: ""),
            .init(url: "https://via.placeholder.com/600x400.png?text=Sample+Image+3", path: ""),
            .init(url: "https://via.placeholder.com/600x400.png?text=Sample+Image+4", path: ""),
            .init(url: "https://via.placeholder.com/600x400.png?text=Sample+Image+5", path: "")
        ],
        policy: .hobby,
        genre: [MusicGenre.pop],
        rehearsalLocation: "新宿スタジオ",
        youtubeVideoURL: ["https://www.youtube.com/watch?v=42G-xzIlr6M"]
    ),
    Recruitment(
        id: UUID().uuidString,
        postedDate: Calendar.current.date(byAdding: .hour, value: -1, to: Date()) ?? Date(),
        author: mockUser2,
        favorite: 20,
        title: "ベーシスト募集！",
        description:
"""
ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。
ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。
ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。
ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。
""",
        policy: Policy.professional,
        frequency: "週１回",
        genre: [MusicGenre.pop],
        rehearsalLocation: "新宿スタジオ",
        youtubeVideoURL: ["https://www.youtube.com/watch?v=NcwGg44KboU"]
    ),
    Recruitment(
        id: UUID().uuidString,
        author: mockUser,
        title: "ジャズドラマー募集中",
        description:
"""
ジャズバンドで一緒に演奏できるドラマーを探しています。ジャズバンドで一緒に演奏できるドラマーを探しています。
ジャズバンドで一緒に演奏できるドラマーを探しています。ジャズバンドで一緒に演奏できるドラマーを探しています。
ジャズバンドで一緒に演奏できるドラマーを探しています。ジャズバンドで一緒に演奏できるドラマーを探しています。
ジャズバンドで一緒に演奏できるドラマーを探しています。
""",
        policy: .professional,
        frequency: "週２〜３回",
        genre: [MusicGenre.jazz],
        rehearsalLocation: "銀座リハーサルスタジオ"
    ),
    Recruitment(
        id: UUID().uuidString,
        author: mockUser2,
        favorite: 70,
        title: "凄腕のキーボーディスト求む！",
        description: "ポップスロックバンドでキーボードを担当できるメンバーを募集しています。ポップスロックバンドでキーボードを担当できるメンバーを募集しています。",
        policy: .professional,
        frequency: "週１〜２回",
        genre: [MusicGenre.pop, MusicGenre.rock],
        rehearsalLocation: "渋谷音楽スタジオ"
    )
]
