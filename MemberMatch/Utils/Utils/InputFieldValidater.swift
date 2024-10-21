//
//  InputFieldValidater.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/09/17.
//

import Foundation

/// 入力値のバリデーションチェックステータス。
enum ValidateStatus {
    case valid             // 異常なし
    case exceedMaxLength   // 入力文字数超過
    case doesNotMeetCriteria // 入力要件を満たしていない
    case emptyField        // 必須フィールドが空
    case invalidFormat     // フォーマットが無効 (例: メールアドレスのフォーマットが不正)
    case outOfRange        // 入力が許容範囲外 (例: 数値範囲の制限を超えている)
}

/// 受け取った入力値のバリデーションチェックを行うクラス。
class InputFieldValidator {
    // 募集内容テキストのバリデーション
    static func validateDescription(_ text: String) {

    }
}
