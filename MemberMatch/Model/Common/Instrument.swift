
enum Instrument: String, CaseIterable, Codable {
    case guitar = "Guitar"
    case bass = "Bass"
    case drums = "Drums"
    case keyboard = "Keyboard"
    case piano = "Piano"
    case saxophone = "Saxophone"
    case trumpet = "Trumpet"
    case violin = "Violin"
    case cello = "Cello"
    case flute = "Flute"
    case clarinet = "Clarinet"
    case vocal = "Vocal"
    case turntables = "Turntables"
    case synthesizer = "Synthesizer"
    case harp = "Harp"

    var jpName: String {
        switch self {
        case .guitar:
            return "ギター"
        case .bass:
            return "ベース"
        case .drums:
            return "ドラム"
        case .keyboard:
            return "キーボード"
        case .piano:
            return "ピアノ"
        case .saxophone:
            return "サクソフォーン"
        case .trumpet:
            return "トランペット"
        case .violin:
            return "バイオリン"
        case .cello:
            return "チェロ"
        case .flute:
            return "フルート"
        case .clarinet:
            return "クラリネット"
        case .vocal:
            return "ボーカル"
        case .turntables:
            return "ターンテーブル"
        case .synthesizer:
            return "シンセサイザー"
        case .harp:
            return "ハープ"
        }
    }
}
