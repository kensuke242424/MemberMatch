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
