//
//  HapticFeedback.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/11/16.
//

import UIKit

class HapticFeedback {
    static let shared = HapticFeedback()

    private init() {} // シングルトンにするため、プライベートな初期化子を定義

    /*     ☑️FeedbackTypeの定義
     •    　 impact(style:): タップやボタンのクリックのような軽い振動。
     •    　 notification(type:): 成功・失敗・警告などの通知フィードバック。
     •    　 selection: リスト選択時などの軽いフィードバック。
     */
    enum FeedbackType {
        case impact(style: UIImpactFeedbackGenerator.FeedbackStyle)
        case notification(type: UINotificationFeedbackGenerator.FeedbackType)
        case selection
    }

    /// ハプティックフィードバックを発動
    func trigger(_ type: FeedbackType) {
        switch type {
        case .impact(let style):
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare() // ハプティックジェネレーターを事前に準備しておくことで、振動の遅延を防止
            generator.impactOccurred()

        case .notification(let notificationType):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(notificationType)

        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
}
