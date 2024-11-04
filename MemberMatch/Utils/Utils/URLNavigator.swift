//
//  URLNavigator.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/11/04.
//

import SwiftUI

class URLNavigator {
    /// 指定したURLを開く
    /// - Parameter urlString: 開きたいURLの文字列
    static func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            Logger.i("urlが無効です")
            return
        }
        UIApplication.shared.open(url)
    }
}
