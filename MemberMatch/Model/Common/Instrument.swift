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
            gender == .male ? Constants.Images.singer_song_writer_male : Constants.Images.singer_song_writer_female
        case .guitar:
            gender == .male ? Constants.Images.guitar_male : Constants.Images.guitar_female
        case .bass:
            gender == .male ? Constants.Images.bass_male : Constants.Images.bass_female
        case .drums:
            gender == .male ? Constants.Images.drums_male : Constants.Images.drums_female
        case .keyboard:
            gender == .male ? Constants.Images.keyboard_male : Constants.Images.keyboard_female
        case .piano:
            gender == .male ? Constants.Images.piano_male : Constants.Images.piano_female
        case .saxophone:
            gender == .male ? Constants.Images.saxophone_male : Constants.Images.saxophone_female
        case .trumpet:
            gender == .male ? Constants.Images.trumpet_male : Constants.Images.trumpet_female
        case .violin:
            gender == .male ? Constants.Images.violin_male : Constants.Images.violin_female
        case .cello:
            gender == .male ? Constants.Images.cello_male : Constants.Images.cello_female
        case .flute:
            gender == .male ? Constants.Images.flute_male : Constants.Images.flute_female
        case .clarinet:
            gender == .male ? Constants.Images.clarinet_male : Constants.Images.clarinet_female
        case .vocal:
            gender == .male ? Constants.Images.vocal_male : Constants.Images.vocal_female
        case .synthesizer:
            gender == .male ? Constants.Images.synthesizer_male : Constants.Images.synthesizer_female
        }
    }
}
