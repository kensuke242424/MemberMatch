//
//  UIScreenExtension.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/06/01.
//

import SwiftUI

// UIScreenの拡張を作成してcornerRadiusプロパティを追加
extension UIScreen {
    // デバイスの種類を判定するメソッド
    var deviceCornerRadius: CGFloat {
        let screenSize = UIScreen.main.bounds.size
        let deviceWidth = min(screenSize.width, screenSize.height)

        switch deviceWidth {
        case 0..<375:
            return 20 // 小型デバイス (iPhone SEなど)
        case 375..<414:
            return 25 // 中型デバイス (iPhone 13など)
        case 414..<768:
            return 30 // 大型デバイス (iPhone 13 Pro Maxなど)
        case 768..<1024:
            return 35 // 小型タブレット (iPad miniなど)
        case 1024..<1366:
            return 40 // 中型タブレット (iPad Pro 11インチなど)
        default:
            return 45 // 大型タブレット (iPad Pro 12.9インチなど)
        }
    }
}
