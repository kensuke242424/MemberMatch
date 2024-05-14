import Foundation

enum MusicGenre: String, CaseIterable, Codable {
    case rock = "Rock"
    case pop = "Pop"
    case jazz = "Jazz"
    case classical = "Classical"
    case hipHop = "Hip-Hop"
    case country = "Country"
    case electronic = "Electronic"
    case reggae = "Reggae"
    case blues = "Blues"
    case folk = "Folk"
    case heavyMetal = "Heavy Metal"
    case punk = "Punk"
    case rAndB = "R&B"
    case latin = "Latin"
    case indie = "Indie"
    case others = "Others"

    var jpName: String {
        switch self {
        case .rock: return "ロック"
        case .pop: return "ポップ"
        case .jazz: return "ジャズ"
        case .classical: return "クラシック"
        case .hipHop: return "ヒップホップ"
        case .country: return "カントリー"
        case .electronic: return "エレクトロニック"
        case .reggae: return "レゲエ"
        case .blues: return "ブルース"
        case .folk: return "フォーク"
        case .heavyMetal: return "ヘヴィメタル"
        case .punk: return "パンク"
        case .rAndB: return "R&B"
        case .latin: return "ラテン"
        case .indie: return "インディ"
        case .others: return "その他"
        }
    }
}
