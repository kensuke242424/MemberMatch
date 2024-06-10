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
    let gender: Gender?

    init(id: UUID = .init(), instrument: Instrument, gender: Gender? = nil) {
        self.id = id
        self.instrument = instrument
        self.gender = gender
    }
}
