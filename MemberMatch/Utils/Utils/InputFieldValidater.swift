//
//  InputFieldValidater.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/09/17.
//

import Foundation

/// 入力値のバリデーションチェックステータス。
enum ValidateStatus {
    case initial            // 初期状態
    case success            // バリデーション成功
    case exceedMaxLength    // 入力文字数超過
    case doesNotMeetCriteria // 入力要件を満たしていない
    case emptyField         // 必須フィールドが空
    case invalidFormat      // フォーマットが無効 (例: メールアドレスのフォーマットが不正)

    var description: String {
        switch self {
        case .initial:
            ""
        case .success:
            ""
        case .exceedMaxLength:
            Constants.Strings.exceedMaxLength
        case .doesNotMeetCriteria:
            Constants.Strings.doesNotMeetCriteria
        case .emptyField:
            Constants.Strings.emptyField
        case .invalidFormat:
            Constants.Strings.invalidFormat
        }
    }
}

/// 受け取った入力値のバリデーションチェックを行うクラス。
class InputFieldValidator {
    // メールアドレス
    static func validateEmail(_ email: String) -> ValidateStatus {
        // フィールドが空かどうかをチェック
        if email.isEmpty {
            return .emptyField
        }

        // メールアドレスの一般的な正規表現パターン
        let emailPattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#

        // 正規表現オブジェクトの作成
        guard let regex = try? NSRegularExpression(pattern: emailPattern, options: .caseInsensitive) else {
            return .invalidFormat
        }

        // 入力がメールアドレスのパターンと一致するかを確認
        let range = NSRange(location: 0, length: email.utf16.count)
        if regex.firstMatch(in: email, options: [], range: range) == nil {
            return .invalidFormat
        }

        // すべてのチェックを通過した場合は成功
        return .success
    }

    // パスワード
    static func validatePassword(_ password: String) -> ValidateStatus {
        // フィールドが空かどうかをチェック
        if password.isEmpty {
            return .emptyField
        }

        // 最小文字数のチェック
        if password.count < 8 {
            return .doesNotMeetCriteria
        }

        // 大文字、小文字、数字を含んでいるかのチェック
        let uppercasePattern = ".*[A-Z]+.*"
        let lowercasePattern = ".*[a-z]+.*"
        let digitPattern = ".*[0-9]+.*"

        // 正規表現のチェックを行う関数
        func matches(pattern: String) -> Bool {
            return NSPredicate(format:"SELF MATCHES %@", pattern).evaluate(with: password)
        }

        if !matches(pattern: uppercasePattern) {
            return .doesNotMeetCriteria
        }
        if !matches(pattern: lowercasePattern) {
            return .doesNotMeetCriteria
        }
        if !matches(pattern: digitPattern) {
            return .doesNotMeetCriteria
        }

        // すべてのチェックを通過した場合は成功
        return .success
    }

    // ✏️　----- 募集作成時の入力値チェック ------ ✏️

    static func validateTitle(_ text: String) -> ValidateStatus {
        let maxLength = 60
        if text.count > maxLength {
            return .exceedMaxLength
        }

        return .success
    }

    static func validateDescription(_ text: String) -> ValidateStatus {
        let maxLength = 400
        if text.count > maxLength {
            return .exceedMaxLength
        }

        return .success
    }

    static func validateFrequency(_ text: String) -> ValidateStatus {
        let maxLength = 80
        if text.count > maxLength {
            return .exceedMaxLength
        }

        return .success
    }

    static func validateRehearsalLocation(_ text: String) -> ValidateStatus {
        let maxLength = 80
        if text.count > maxLength {
            return .exceedMaxLength
        }

        return .success
    }

    static func validateAdditionalInfo(_ text: String) -> ValidateStatus {
        let maxLength = 200
        if text.count > maxLength {
            return .exceedMaxLength
        }

        return .success
    }

    static func validateTwitterURL(_ urlString: String) -> ValidateStatus {
        // フィールドが空かどうかをチェック
        if urlString.isEmpty {
            return .success
        }
        // 最大文字数をチェック（例：Twitter URL の長さの制限に応じて調整可能）
        let maxLength = 100
        if urlString.count > maxLength {
            return .exceedMaxLength
        }

        // X(Twitter) URL形式に合致する正規表現パターン
        let pattern = #"^https?:\/\/(www\.)?(twitter|x)\.com\/[A-Za-z0-9_]{1,15}(\/)?$"#

        // 正規表現オブジェクトの作成
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return .invalidFormat
        }

        // 入力がURLパターンと一致するかを確認
        let range = NSRange(location: 0, length: urlString.utf16.count)
        if regex.firstMatch(in: urlString, options: [], range: range) == nil {
            return .invalidFormat
        }

        // 追加要件（例：HTTPSで始まるか）のチェック
        if !urlString.starts(with: "https") {
            return .doesNotMeetCriteria
        }

        return .success
    }

    static func validateInstagramURL(_ urlString: String) -> ValidateStatus {
        // フィールドが空かどうかをチェック
        if urlString.isEmpty {
            return .success
        }
        // 最大文字数をチェック（例：Instagram URL の長さの制限に応じて調整可能）
        let maxLength = 100 // 必要に応じて maxLength を変更
        if urlString.count > maxLength {
            return .exceedMaxLength
        }

        // Instagram URL形式に合致する正規表現パターン
        let pattern = #"^https?:\/\/(www\.)?instagram\.com\/[A-Za-z0-9_.]+(\/)?$"#

        // 正規表現オブジェクトの作成
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return .invalidFormat
        }

        // 入力がURLパターンと一致するかを確認
        let range = NSRange(location: 0, length: urlString.utf16.count)
        if regex.firstMatch(in: urlString, options: [], range: range) == nil {
            return .invalidFormat
        }

        // 追加要件（例：HTTPSで始まるか）のチェック
        if !urlString.starts(with: "https") {
            return .doesNotMeetCriteria
        }

        // すべてのチェックを通過した場合は成功
        return .success
    }

    static func validateFacebookURL(_ urlString: String) -> ValidateStatus {
        // フィールドが空かどうかをチェック
        if urlString.isEmpty {
            return .success
        }
        // 最大文字数をチェック（例：Facebook URL の長さの制限に応じて調整可能）
        let maxLength = 100 // 必要に応じて maxLength を変更
        if urlString.count > maxLength {
            return .exceedMaxLength
        }

        // Facebook URL形式に合致する正規表現パターン
        let pattern = #"^https?:\/\/(www\.)?facebook\.com\/[A-Za-z0-9_.]+(\/)?$"#

        // 正規表現オブジェクトの作成
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return .invalidFormat
        }

        // 入力がURLパターンと一致するかを確認
        let range = NSRange(location: 0, length: urlString.utf16.count)
        if regex.firstMatch(in: urlString, options: [], range: range) == nil {
            return .invalidFormat
        }

        // 追加要件（例：HTTPSで始まるか）のチェック
        if !urlString.starts(with: "https") {
            return .doesNotMeetCriteria
        }

        return .success
    }

    static func validateYouTubeURL(_ urlString: String) -> ValidateStatus {
        // フィールドが空かどうかをチェック
        if urlString.isEmpty {
            return .success
        }
        // 最大文字数をチェック（例：YouTube URLの長さの制限に応じて調整可能）
        let maxLength = 100 // 必要に応じてmaxLengthを変更
        if urlString.count > maxLength {
            return .exceedMaxLength
        }

        // YouTube URL形式に合致する正規表現パターン
        let pattern = #"^https?:\/\/(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)[A-Za-z0-9_-]{11}$"#

        // 正規表現オブジェクトの作成
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return .invalidFormat
        }

        // 入力がURLパターンと一致するかを確認
        let range = NSRange(location: 0, length: urlString.utf16.count)
        if regex.firstMatch(in: urlString, options: [], range: range) == nil {
            return .invalidFormat
        }

        // 追加要件（例：HTTPSで始まるか）のチェック
        if !urlString.starts(with: "https") {
            return .doesNotMeetCriteria
        }

        return .success
    }
}
