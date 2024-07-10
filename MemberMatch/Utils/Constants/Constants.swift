//
//  Constants.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/19.
//

import SwiftUI

struct Constants {
    // ツールバー
    static let toolBarItemSize: CGFloat = 30

    static let musicGenreTexts = MusicGenre.allCases.map { $0.text }
}

extension Constants {
    struct Strings {
        // --- View ---
        // 掲示板ページ
        static let recruitmentPageTitle = String(localized: "recruitment_page_title")
        static let recruitmentDetailPageTitle = String(localized: "recruitment_detail_page_title")
        static let author = String(localized: "author")
        static let favorite = String(localized: "favorite")
        static let publicDeadline = String(localized: "public_deadline")
        static let publicDeadlineDesc1 = String(localized: "public_deadline_desc1")
        static let publicDeadlineDesc2 = String(localized: "public_deadline_desc2")
        static let musicGenreTitle = String(localized: "music_genre_title")
        static let recruitmentTitleTitle = String(localized: "recruitment_title_title")
        static let recruitmentDescTitle = String(localized: "recruitment_desc_title")
        static let wantedPartsTitle = String(localized: "wanted_parts_title")
        static let photoTitle = String(localized: "photo_title")
        static let policyTitle = String(localized: "policy_title")
        static let frequencyTitle = String(localized: "frequency_title")
        static let locationTitle = String(localized: "location_title")
        static let youtubeTitle = String(localized: "youtube_title")
        static let twitterTitle = String(localized: "twitter_title")
        static let instagramTitle = String(localized: "instagram_title")
        static let facebookTitle = String(localized: "facebook_title")
        static let additionalInfoTitle = String(localized: "additional_info_title")
        static let sendMessage = String(localized: "send_message")
        static let draftButtonText = String(localized: "draft_button_text")
        static let profileText = String(localized: "profile")

        // placeHolder
        static let placeHolderTitle = String(localized: "place_holder_title")
        static let placeHolderDescription = String(localized: "place_holder_description")
        static let placeHolderFrequency = String(localized: "place_holder_frequency")
        static let placeHolderRehearsalLocation = String(localized: "place_holder_rehearsal_location")
        static let placeHolderAdditionalInfo = String(localized: "place_holder_additional_info")
        static let placeHolderYoutubeURL = String(localized: "placeHolder_youtube_url")
        static let placeHolderTwitterURL = String(localized: "placeHolder_twitter_url")
        static let placeHolderInstagramURL = String(localized: "placeHolder_instagram_url")
        static let placeHolderFacebookURL = String(localized: "placeHolder_facebook_url")

        // ViewParts
        static let hideKeyboardToolBarButtonText = String(localized: "hide_keyboard_tool_bar_button_text")

        // 募集作成ページ
        static let createRecruitmentPageTitle = String(localized: "create_recruitment_page_title")
        static let editRecruitmentPageTitle = String(localized: "edit_recruitment_page_title")

        // Empty
        static let emptyName = String(localized: "empty_name")
        static let emptyTitle = String(localized: "empty_title")
        static let emptyDescription = String(localized: "empty_description")
        static let emptyPolicy = String(localized: "empty_policy")

        // --- Model ---
        // Policy
        static let policy_nothing = String(localized: "policy_nothing")
        static let policy_hobby = String(localized: "policy_hobby")
        static let policy_professional = String(localized: "policy_professional")

        // SkillLevel
        static let skill_level_beginner = String(localized: "skill_level_beginner")
        static let skill_level_novice = String(localized: "skill_level_novice")
        static let skill_level_intermediate = String(localized: "skill_level_intermediate")
        static let skill_level_advanced = String(localized: "skill_level_advanced")
        static let skill_level_expert = String(localized: "skill_level_expert")

        // Instrument
        static let instrument_song_writer = String(localized: "instrument_song_writer")
        static let instrument_guitar = String(localized: "instrument_guitar")
        static let instrument_bass = String(localized: "instrument_bass")
        static let instrument_drums = String(localized: "instrument_drums")
        static let instrument_keyboard = String(localized: "instrument_keyboard")
        static let instrument_piano = String(localized: "instrument_piano")
        static let instrument_saxophone = String(localized: "instrument_saxophone")
        static let instrument_trumpet = String(localized: "instrument_trumpet")
        static let instrument_violin = String(localized: "instrument_violin")
        static let instrument_cello = String(localized: "instrument_cello")
        static let instrument_flute = String(localized: "instrument_flute")
        static let instrument_clarinet = String(localized: "instrument_clarinet")
        static let instrument_vocal = String(localized: "instrument_vocal")
        static let instrument_synthesizer = String(localized: "instrument_synthesizer")

        // MusicGenre
        static let music_genre_rock = String(localized: "music_genre_rock")
        static let music_genre_pop = String(localized: "music_genre_pop")
        static let music_genre_jazz = String(localized: "music_genre_jazz")
        static let music_genre_classical = String(localized: "music_genre_classical")
        static let music_genre_hipHop = String(localized: "music_genre_hipHop")
        static let music_genre_country = String(localized: "music_genre_country")
        static let music_genre_electronic = String(localized: "music_genre_electronic")
        static let music_genre_reggae = String(localized: "music_genre_reggae")
        static let music_genre_blues = String(localized: "music_genre_blues")
        static let music_genre_folk = String(localized: "music_genre_folk")
        static let music_genre_heavyMetal = String(localized: "music_genre_heavyMetal")
        static let music_genre_punk = String(localized: "music_genre_punk")
        static let music_genre_rAndB = String(localized: "music_genre_rAndB")
        static let music_genre_latin = String(localized: "music_genre_latin")
        static let music_genre_indie = String(localized: "music_genre_indie")
        static let music_genre_others = String(localized: "music_genre_others")

        // CommitmentLevel
        static let commitment_level_casual = String(localized: "commitment_level_casual")
        static let commitment_level_serious = String(localized: "commitment_level_serious")
        static let commitment_level_professional = String(localized: "commitment_level_professional")

        // Gender
        static let gender_male = String(localized: "gender_male")
        static let gender_female = String(localized: "gender_female")
        static let gender_unknown = String(localized: "gender_unknown")

        // Browse
        static let browse_all = String(localized: "browse_all")
        static let browse_single = String(localized: "browse_single")
        static let browse_group = String(localized: "browse_group")
    }
}

extension Constants {
    struct Symbols {
        // SF Symbols
        static let chevron_backward: String = "chevron.backward"
        static let chevron_up: String = "chevron.up"
        static let chevron_down: String = "chevron.down"
        static let pin: String = "pin"
        static let pin_fill: String = "pin.fill"
        static let heart: String = "heart"
        static let heart_fill: String = "heart.fill"
        static let bubble_left_fill: String = "bubble.left.fill"
        static let square_and_pencil: String = "square.and.pencil"
        static let photo_on_rectangle_angled: String = "photo.on.rectangle.angled"
        static let plus_circle_fill: String = "plus.circle.fill"
        static let checkmark: String = "checkmark"
        static let xmark: String = "xmark"
    }
}

extension Constants {
    struct Images {
        // 楽器パート
        // シンガーソングライター
        static let singer_song_writer_male: String = "singer_song_writer_male"
        static let singer_song_writer_female: String = "singer_song_writer_female"
        // ギター
        static let guitar_male: String = "guitar_male"
        static let guitar_female: String = "guitar_female"
        // ベース
        static let bass_male: String = "bass_male"
        static let bass_female: String = "bass_female"
        // ドラム
        static let drums_male: String = "drums_male"
        static let drums_female: String = "drums_female"
        // キーボード
        static let keyboard_male: String = "keyboard_male"
        static let keyboard_female: String = "keyboard_female"
        // ピアノ
        static let piano_male: String = "piano_male"
        static let piano_female: String = "piano_female"
        // サックス
        static let saxophone_male: String = "saxophone_male"
        static let saxophone_female: String = "saxophone_female"
        // トランペット
        static let trumpet_male: String = "trumpet_male"
        static let trumpet_female: String = "trumpet_female"
        // バイオリン
        static let violin_male: String = "violin_male"
        static let violin_female: String = "violin_female"
        // チェロ
        static let cello_male: String = "cello_male"
        static let cello_female: String = "cello_female"
        // フルート
        static let flute_male: String = "flute_male"
        static let flute_female: String = "flute_female"
        // クラリネット
        static let clarinet_male: String = "clarinet_male"
        static let clarinet_female: String = "clarinet_female"
        // ボーカル
        static let vocal_male: String = "vocal_male"
        static let vocal_female: String = "vocal_female"
        // トランペット
        static let turntables_male: String = "turntables_male"
        static let turntables_female: String = "turntables_female"
        // シンセサイザー
        static let synthesizer_male: String = "synthesizer_male"
        static let synthesizer_female: String = "synthesizer_female"

        // 活動方針
        static let band_enjoy: String = "band_enjoy"
    }
}
