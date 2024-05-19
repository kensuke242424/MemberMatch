/*
 id: 募集情報を一意に識別するためのID。
 title: 募集のタイトル。
 description: 募集内容の詳細な説明。
 postedDate: 募集が投稿された日時。
 deadline: 応募締切日。
 location: 募集の場所またはリモートワークの可能性。
 category: 募集が属するカテゴリ（例：テクノロジー、マーケティングなど）。
 contactEmail: 応募や問い合わせ用の連絡先メールアドレス。
 additionalInfo: 追加情報（任意）。
 */

import Foundation

struct Recruitment: Identifiable, Hashable {
    let id: String
    let user: User
    let title: String
    let description: String
    let postedDate: Date
    let deadline: Date
    let genre: String
    let instrument: String
    let bandType: String
    let rehearsalLocation: String
    let contactEmail: String
    let additionalInfo: String?

    init(
        id: String = UUID().uuidString,
        user: User,
        title: String,
        description: String,
        postedDate: Date = Date(),
        deadline: Date,
        genre: String,
        instrument: String,
        bandType: String,
        rehearsalLocation: String,
        contactEmail: String,
        additionalInfo: String? = nil
    ) {
        self.id = id
        self.user = user
        self.title = title
        self.description = description
        self.postedDate = postedDate
        self.deadline = deadline
        self.genre = genre
        self.instrument = instrument
        self.bandType = bandType
        self.rehearsalLocation = rehearsalLocation
        self.contactEmail = contactEmail
        self.additionalInfo = additionalInfo
    }
}

// ダミーデータ
let exampleRecruitments = [
    Recruitment(
        id: UUID().uuidString,
        user: mockUser,
        title: "ベーシスト募集！",
        description: "ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。ポップスバンドで経験豊富なベーシストを探しています。",
        deadline: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
        genre: "ポップス",
        instrument: "ベース",
        bandType: "ポップスバンド",
        rehearsalLocation: "新宿スタジオ",
        contactEmail: "join@popsband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        user: mockUser,
        title: "ジャズドラマー募集中",
        description: "ジャズバンドで一緒に演奏できるドラマーを探しています。ジャズバンドで一緒に演奏できるドラマーを探しています。ジャズバンドで一緒に演奏できるドラマーを探しています。ジャズバンドで一緒に演奏できるドラマーを探しています。ジャズバンドで一緒に演奏できるドラマーを探しています。ジャズバンドで一緒に演奏できるドラマーを探しています。ジャズバンドで一緒に演奏できるドラマーを探しています。",
        deadline: Calendar.current.date(byAdding: .day, value: 45, to: Date())!,
        genre: "ジャズ",
        instrument: "ドラム",
        bandType: "ジャズバンド",
        rehearsalLocation: "銀座リハーサルスタジオ",
        contactEmail: "apply@jazzband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        user: mockUser,
        title: "凄腕のキーボーディスト求む！",
        description: "ポップスロックバンドでキーボードを担当できるメンバーを募集しています。ポップスロックバンドでキーボードを担当できるメンバーを募集しています。",
        deadline: Calendar.current.date(byAdding: .day, value: 25, to: Date())!,
        genre: "ポップスロック",
        instrument: "キーボード",
        bandType: "ポップスロックバンド",
        rehearsalLocation: "渋谷音楽スタジオ",
        contactEmail: "contact@poprockband.com"
    ),
]
