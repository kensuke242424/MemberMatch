//
//  DateExtension.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/10/28.
//

import Foundation

extension Date {
    func format() -> String {
        let calendar = Calendar.current
        let today = Date()

        if calendar.isDateInToday(self) {
            let hours = calendar.dateComponents([.hour], from: self, to: today).hour ?? 0
            if hours == 0 {
                return "1時間以内"
            } else {
                return "\(hours)時間前"
            }
        } else if calendar.isDateInYesterday(self) {
            return "昨日"
        } else if let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: today), self >= oneWeekAgo {
            return "１週間前"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            return formatter.string(from: self)
        }
    }
}
