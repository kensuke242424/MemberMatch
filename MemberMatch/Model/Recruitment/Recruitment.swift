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
 contactEmail: 応募や問い合わせ用の連絡先メールアドレス。
 additionalInfo: 追加情報（任意）。
 */

import Foundation

struct Recruitment: Identifiable, Hashable {
    let id: String
    let postedDate: Date
    var deadlineDate: Date
    let author: User
    var title: String
    var description: String
    var policy: Policy?
    var frequency: String?
    var genre: [MusicGenre]?
    var wantedParts: [Part]?
    var rehearsalLocation: String
    var contactEmail: String
    var additionalInfo: String?
    var youtubeVideoURL: [URL]?  // YouTube動画のURL

    init(
        id: String = UUID().uuidString,
        postedDate: Date = Date(),
        deadline: Date,
        author: User,
        title: String,
        description: String,
        policy: Policy?,
        frequency: String? = nil,
        genre: [MusicGenre]? = nil,
        wantedParts: [Part]? = nil,
        rehearsalLocation: String,
        contactEmail: String,
        additionalInfo: String? = nil,
        youtubeVideoURL: [URL]? = nil
    ) {
        self.id = id
        self.author = author
        self.title = title
        self.description = description
        self.postedDate = postedDate
        self.deadlineDate = deadline
        self.policy = policy
        self.genre = genre
        self.frequency = frequency
        self.wantedParts = wantedParts
        self.rehearsalLocation = rehearsalLocation
        self.contactEmail = contactEmail
        self.additionalInfo = additionalInfo
        self.youtubeVideoURL = youtubeVideoURL
    }
}

// ダミーデータ
let exampleRecruitments = [
    Recruitment(
        id: UUID().uuidString,
        deadline: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
        author: mockUser,
        title: "POPバンドのメンバー大募集！ガチでやろうぜ！",
        description:
"""
ポップスバンドで経験豊富なバンドメンバーを探しています。ポップスバンドで経験豊富なバンドメンバーを探しています。
ポップスバンドで経験豊富なバンドメンバーを探しています。ポップスバンドで経験豊富なバンドメンバーを探しています。
""",
        policy: .hobby,
        genre: [MusicGenre.pop],
        wantedParts: [
            Part(instrument: .songWriter, gender: Gender.male),
            Part(instrument: .songWriter, gender: Gender.female),
            Part(instrument: .guitar, gender: Gender.male),
            Part(instrument: .guitar, gender: Gender.female),
            Part(instrument: .bass, gender: Gender.male),
            Part(instrument: .bass, gender: Gender.female),
            Part(instrument: .drums, gender: Gender.male),
            Part(instrument: .drums, gender: Gender.female),
            Part(instrument: .keyboard, gender: Gender.male),
            Part(instrument: .keyboard, gender: Gender.female),
            Part(instrument: .piano, gender: Gender.male),
            Part(instrument: .piano, gender: Gender.female),
            Part(instrument: .saxophone, gender: Gender.male),
            Part(instrument: .saxophone, gender: Gender.female),
            Part(instrument: .trumpet, gender: Gender.male),
            Part(instrument: .trumpet, gender: Gender.female),
            Part(instrument: .violin, gender: Gender.male),
            Part(instrument: .violin, gender: Gender.female),
            Part(instrument: .cello, gender: Gender.male),
            Part(instrument: .cello, gender: Gender.female),
            Part(instrument: .flute, gender: Gender.male),
            Part(instrument: .flute, gender: Gender.female),
            Part(instrument: .clarinet, gender: Gender.male),
            Part(instrument: .clarinet, gender: Gender.female),
            Part(instrument: .vocal, gender: Gender.male),
            Part(instrument: .vocal, gender: Gender.female),
            Part(instrument: .synthesizer, gender: Gender.male),
            Part(instrument: .synthesizer, gender: Gender.female)
        ],
        rehearsalLocation: "新宿スタジオ",
        contactEmail: "join@popsband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        deadline: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
        author: mockUser,
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
        wantedParts: [Part(instrument: .bass, gender: Gender.male)],
        rehearsalLocation: "新宿スタジオ",
        contactEmail: "join@popsband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        deadline: Calendar.current.date(byAdding: .day, value: 45, to: Date())!,
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
        wantedParts: [Part(instrument: .drums, gender: Gender.female)],
        rehearsalLocation: "銀座リハーサルスタジオ",
        contactEmail: "apply@jazzband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        deadline: Calendar.current.date(byAdding: .day, value: 25, to: Date())!,
        author: mockUser,
        title: "凄腕のキーボーディスト求む！",
        description: "ポップスロックバンドでキーボードを担当できるメンバーを募集しています。ポップスロックバンドでキーボードを担当できるメンバーを募集しています。",
        policy: .professional,
        frequency: "週１〜２回",
        genre: [MusicGenre.pop, MusicGenre.rock],
        wantedParts: [Part(instrument: .keyboard, gender: .male)],
        rehearsalLocation: "渋谷音楽スタジオ",
        contactEmail: "contact@poprockband.com"
    )
]
