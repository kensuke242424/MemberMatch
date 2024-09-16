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

    var text: String {
        switch self {
        case .songWriter:
            return Constants.Strings.instrument_song_writer
        case .guitar:
            return Constants.Strings.instrument_guitar
        case .bass:
            return Constants.Strings.instrument_bass
        case .drums:
            return Constants.Strings.instrument_drums
        case .keyboard:
            return Constants.Strings.instrument_keyboard
        case .piano:
            return Constants.Strings.instrument_piano
        case .saxophone:
            return Constants.Strings.instrument_saxophone
        case .trumpet:
            return Constants.Strings.instrument_trumpet
        case .violin:
            return Constants.Strings.instrument_violin
        case .cello:
            return Constants.Strings.instrument_cello
        case .flute:
            return Constants.Strings.instrument_flute
        case .clarinet:
            return Constants.Strings.instrument_clarinet
        case .vocal:
            return Constants.Strings.instrument_vocal
        case .synthesizer:
            return Constants.Strings.instrument_synthesizer
        }
    }
}
