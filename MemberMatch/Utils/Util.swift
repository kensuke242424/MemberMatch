//
//  Util.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/06/15.
//

import Foundation

struct Util {
    /// 掲示板への掲載日から掲載終了までの日数を出力する。
    static func daysUntilDeadline(from createDate: Date) -> Int {
        let calendar = Calendar.current

        // 7日後のデッドラインを計算
        guard let deadlineDate = calendar.date(byAdding: .day, value: 7, to: createDate) else {
            fatalError("デッドラインの日付を計算できませんでした")
        }

        // 現在の日付を取得
        let currentDate = Date()

        // デッドラインまでの日数を計算
        let components = calendar.dateComponents([.day], from: currentDate, to: deadlineDate)

        // 日数を返す
        return components.day ?? 0
    }
}
