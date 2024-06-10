//
//  Instrument.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

enum Instrument: String, CaseIterable, Codable {
    case songWriter = "SongWriter"
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
    case synthesizer = "Synthesizer"

    var jpName: String {
        switch self {
        case .songWriter:
            return "ソングライター"
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
            return "サックス"
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
        case .synthesizer:
            return "シンセサイザー"
        }
    }

    func iconName(for gender: Gender) -> String {
        switch self {
        case .songWriter: 
            gender == .male ? Constants.singer_song_writer_male : Constants.singer_song_writer_female
        case .guitar:
            gender == .male ? Constants.guitar_male : Constants.guitar_female
        case .bass:
            gender == .male ? Constants.bass_male : Constants.bass_female
        case .drums:
            gender == .male ? Constants.drums_male : Constants.drums_female
        case .keyboard:
            gender == .male ? Constants.keyboard_male : Constants.keyboard_female
        case .piano:
            gender == .male ? Constants.piano_male : Constants.piano_female
        case .saxophone:
            gender == .male ? Constants.saxophone_male : Constants.saxophone_female
        case .trumpet:
            gender == .male ? Constants.trumpet_male : Constants.trumpet_female
        case .violin:
            gender == .male ? Constants.violin_male : Constants.violin_female
        case .cello:
            gender == .male ? Constants.cello_male : Constants.cello_female
        case .flute:
            gender == .male ? Constants.flute_male : Constants.flute_female
        case .clarinet:
            gender == .male ? Constants.clarinet_male : Constants.clarinet_female
        case .vocal:
            gender == .male ? Constants.vocal_male : Constants.vocal_female
        case .synthesizer:
            gender == .male ? Constants.synthesizer_male : Constants.synthesizer_female
        }
    }
}
