//
//  Part.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/06/09.
//

import Foundation

struct Part: Identifiable, Codable, Equatable, Hashable {
    var id: UUID
    let instrument: Instrument
    var gender: Gender
    var isWanted: Bool

    init(id: UUID = .init(), instrument: Instrument, gender: Gender) {
        self.id = id
        self.instrument = instrument
        self.gender = gender
        self.isWanted = false
    }

    let user = UserManager.shared.currentUser

    static func getAllContent() -> [Part] {
        var data: [Part] = []
        for instrument in Instrument.allCases {
            data.append(Part(instrument: instrument, gender: Gender.unknown))
        }
        return data
    }

    var iconName: String {
        switch self.instrument {
        case .songWriter:
            switch gender {
            case .male: 
                return Constants.Images.singer_song_writer_male
            case .female: 
                return Constants.Images.singer_song_writer_female
            case .unknown:
                return user.gender == .male ? Constants.Images.singer_song_writer_male :
                user.gender == .female ? Constants.Images.singer_song_writer_female :
                [Constants.Images.singer_song_writer_male, Constants.Images.singer_song_writer_female].randomElement()!
            }
        case .guitar:
            switch gender {
            case .male:
                return Constants.Images.guitar_male
            case .female:
                return Constants.Images.guitar_female
            case .unknown:
                return user.gender == .male ? Constants.Images.guitar_male :
                user.gender == .female ? Constants.Images.guitar_female :
                [Constants.Images.guitar_male, Constants.Images.guitar_female].randomElement()!
            }
        case .bass:
            switch gender {
            case .male:
                return Constants.Images.bass_male
            case .female:
                return Constants.Images.bass_female
            case .unknown:
                return user.gender == .male ? Constants.Images.bass_male :
                user.gender == .female ? Constants.Images.bass_female :
                [Constants.Images.bass_male, Constants.Images.bass_female].randomElement()!
            }
        case .drums:
            switch gender {
            case .male:
                return Constants.Images.drums_male
            case .female:
                return Constants.Images.drums_female
            case .unknown:
                return user.gender == .male ? Constants.Images.drums_male :
                user.gender == .female ? Constants.Images.drums_female :
                [Constants.Images.drums_male, Constants.Images.drums_female].randomElement()!
            }
        case .keyboard:
            switch gender {
            case .male:
                return Constants.Images.keyboard_male
            case .female:
                return Constants.Images.keyboard_female
            case .unknown:
                return user.gender == .male ? Constants.Images.keyboard_male :
                user.gender == .female ? Constants.Images.keyboard_female :
                [Constants.Images.keyboard_male, Constants.Images.keyboard_female].randomElement()!
            }
        case .piano:
            switch gender {
            case .male:
                return Constants.Images.piano_male
            case .female:
                return Constants.Images.piano_female
            case .unknown:
                return user.gender == .male ? Constants.Images.piano_male :
                user.gender == .female ? Constants.Images.piano_female :
                [Constants.Images.piano_male, Constants.Images.piano_female].randomElement()!
            }
        case .saxophone:
            switch gender {
            case .male:
                return Constants.Images.saxophone_male
            case .female:
                return Constants.Images.saxophone_female
            case .unknown:
                return user.gender == .male ? Constants.Images.saxophone_male :
                user.gender == .female ? Constants.Images.saxophone_female :
                [Constants.Images.saxophone_male, Constants.Images.saxophone_female].randomElement()!
            }
        case .trumpet:
            switch gender {
            case .male:
                return Constants.Images.trumpet_male
            case .female:
                return Constants.Images.trumpet_female
            case .unknown:
                return user.gender == .male ? Constants.Images.trumpet_male :
                user.gender == .female ? Constants.Images.trumpet_female :
                [Constants.Images.trumpet_male, Constants.Images.trumpet_female].randomElement()!
            }
        case .violin:
            switch gender {
            case .male:
                return Constants.Images.violin_male
            case .female:
                return Constants.Images.violin_female
            case .unknown:
                return user.gender == .male ? Constants.Images.violin_male :
                user.gender == .female ? Constants.Images.violin_female :
                [Constants.Images.violin_male, Constants.Images.violin_female].randomElement()!
            }
        case .cello:
            switch gender {
            case .male:
                return Constants.Images.cello_male
            case .female:
                return Constants.Images.cello_female
            case .unknown:
                return user.gender == .male ? Constants.Images.cello_male :
                user.gender == .female ? Constants.Images.cello_female :
                [Constants.Images.cello_male, Constants.Images.cello_female].randomElement()!
            }
        case .flute:
            switch gender {
            case .male:
                return Constants.Images.flute_male
            case .female:
                return Constants.Images.flute_female
            case .unknown:
                return user.gender == .male ? Constants.Images.flute_male :
                user.gender == .female ? Constants.Images.flute_female :
                [Constants.Images.flute_male, Constants.Images.flute_female].randomElement()!
            }
        case .clarinet:
            switch gender {
            case .male:
                return Constants.Images.clarinet_male
            case .female:
                return Constants.Images.clarinet_female
            case .unknown:
                return user.gender == .male ? Constants.Images.clarinet_male :
                user.gender == .female ? Constants.Images.clarinet_female :
                [Constants.Images.flute_male, Constants.Images.clarinet_female].randomElement()!
            }
        case .vocal:
            switch gender {
            case .male:
                return Constants.Images.vocal_male
            case .female:
                return Constants.Images.vocal_female
            case .unknown:
                return user.gender == .male ? Constants.Images.vocal_male :
                user.gender == .female ? Constants.Images.vocal_female :
                [Constants.Images.vocal_male, Constants.Images.vocal_female].randomElement()!
            }
        case .synthesizer:
            switch gender {
            case .male:
                return Constants.Images.synthesizer_male
            case .female:
                return Constants.Images.synthesizer_female
            case .unknown:
                return user.gender == .male ? Constants.Images.synthesizer_male :
                user.gender == .female ? Constants.Images.synthesizer_female :
                [Constants.Images.synthesizer_male, Constants.Images.synthesizer_female].randomElement()!
            }
        }
    }
}
