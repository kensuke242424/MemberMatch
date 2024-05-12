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
        title: "ベーシスト募集！",
        description: "ポップスバンドで経験豊富なベーシストを探しています。",
        deadline: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
        genre: "ポップス",
        instrument: "ベース",
        bandType: "ポップスバンド",
        rehearsalLocation: "新宿スタジオ",
        contactEmail: "join@popsband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        title: "ジャズドラマー募集中",
        description: "ジャズバンドで一緒に演奏できるドラマーを探しています。",
        deadline: Calendar.current.date(byAdding: .day, value: 45, to: Date())!,
        genre: "ジャズ",
        instrument: "ドラム",
        bandType: "ジャズバンド",
        rehearsalLocation: "銀座リハーサルスタジオ",
        contactEmail: "apply@jazzband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        title: "キーボーディスト求む！",
        description: "ポップスロックバンドでキーボードを担当できるメンバーを募集しています。",
        deadline: Calendar.current.date(byAdding: .day, value: 25, to: Date())!,
        genre: "ポップスロック",
        instrument: "キーボード",
        bandType: "ポップスロックバンド",
        rehearsalLocation: "渋谷音楽スタジオ",
        contactEmail: "contact@poprockband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        title: "ボーカル募集中",
        description: "アコースティックバンドでボーカルとして参加いただける方を募集しています。",
        deadline: Calendar.current.date(byAdding: .day, value: 20, to: Date())!,
        genre: "アコースティック",
        instrument: "ボーカル",
        bandType: "アコースティックバンド",
        rehearsalLocation: "池袋リハーサルルーム",
        contactEmail: "voice@acousticband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        title: "女性ボーカルを募集！",
        description: "新規結成するガールズバンドで、女性ボーカリストを探しています。元気でポップなスタイルが好きな方、大歓迎！",
        deadline: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
        genre: "ポップス",
        instrument: "ボーカル",
        bandType: "ガールズバンド",
        rehearsalLocation: "横浜リハーサルスタジオ",
        contactEmail: "vocal@girlsband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        title: "ギタリスト募集",
        description: "インディーズロックバンドで、エネルギッシュなギタリストを探しています。自作のオリジナル曲を一緒に作り上げませんか？",
        deadline: Calendar.current.date(byAdding: .day, value: 40, to: Date())!,
        genre: "インディーズロック",
        instrument: "ギター",
        bandType: "インディーズバンド",
        rehearsalLocation: "大阪ライブハウス",
        contactEmail: "guitar@indierockband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        title: "ドラム奏者求む！",
        description: "ジャズバンドで経験豊富なドラム奏者を探しています。即興演奏が得意な方を歓迎します！",
        deadline: Calendar.current.date(byAdding: .day, value: 35, to: Date())!,
        genre: "ジャズ",
        instrument: "ドラム",
        bandType: "ジャズバンド",
        rehearsalLocation: "札幌ミュージックスタジオ",
        contactEmail: "drums@jazzband.com"
    ),
    Recruitment(
        id: UUID().uuidString,
        title: "アコースティックギターリストを募集",
        description: "カフェでのライブやアコースティックイベントで一緒に演奏してくれるギタリストを探しています。",
        deadline: Calendar.current.date(byAdding: .day, value: 28, to: Date())!,
        genre: "アコースティック",
        instrument: "アコースティックギター",
        bandType: "アコースティックデュオ",
        rehearsalLocation: "福岡アコースティックスタジオ",
        contactEmail: "acoustic@duo.com"
    )
]
