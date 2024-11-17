//
//  AppState.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/11/17.
//

import Foundation

// アプリ全体で用いる状態の管理クラス。
class AppState: ObservableObject {
    static let shared = AppState()
    // アプリの状態
    @Published var isAuthenticated: Bool = true
    @Published var isOnline: Bool = true
    @Published var isLoading: Bool = false

    // エラーダイアログ
    @Published var showGlobalError: Bool = false
    @Published var globalErrorMessage: String? = nil

    // トースト
    @Published var showGlobalToast: Bool = false
    @Published var globalToastMessage: String? = nil

    private init() {}
}
