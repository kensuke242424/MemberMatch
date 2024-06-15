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

    var text: String {
        switch self {
        case .rock:
            return Constants.Strings.music_genre_rock
        case .pop:
            return Constants.Strings.music_genre_pop
        case .jazz:
            return Constants.Strings.music_genre_jazz
        case .classical:
            return Constants.Strings.music_genre_classical
        case .hipHop:
            return Constants.Strings.music_genre_hipHop
        case .country:
            return Constants.Strings.music_genre_country
        case .electronic:
            return Constants.Strings.music_genre_electronic
        case .reggae:
            return Constants.Strings.music_genre_reggae
        case .blues:
            return Constants.Strings.music_genre_blues
        case .folk:
            return Constants.Strings.music_genre_folk
        case .heavyMetal:
            return Constants.Strings.music_genre_heavyMetal
        case .punk:
            return Constants.Strings.music_genre_punk
        case .rAndB:
            return Constants.Strings.music_genre_rAndB
        case .latin:
            return Constants.Strings.music_genre_latin
        case .indie:
            return Constants.Strings.music_genre_indie
        case .others:
            return Constants.Strings.music_genre_others
        }
    }
}
