//
//  YouTubePlayerView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/10/28.
//

import SwiftUI
import WebKit

enum LoadingStatus: Equatable {
    case idle          // 初期状態やローディングが開始されていない状態
    case loading       // データのローディング中
    case success       // ロード完了
    case failure(Error) // ロードに失敗した場合、エラーを含む

    // Equatable準拠の実装
    static func == (lhs: LoadingStatus, rhs: LoadingStatus) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
            (.loading, .loading),
            (.success, .success):
            return true
        case (.failure, .failure):
            return true // エラーの内容を無視して同じとみなす
        default:
            return false
        }
    }
}

struct Video: UIViewRepresentable {
    let videoID: String
    @Binding var isLoading: LoadingStatus

    func makeCoordinator() -> Video.Coordinator {
        Coordinator(isLoading: $isLoading)
    }

    func makeUIView(context: Context) -> some WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard isLoading == .idle || isLoading == .loading else { return }
        // YouTube動画のURLを作成し、ロードを開始
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)?playsinline=1") else {
            return
        }

        // ロード開始状態に設定
        DispatchQueue.main.async {
            self.isLoading = .loading
        }

        uiView.load(URLRequest(url: youtubeURL))
    }

    // ビデオのローディング状況を監視するコーディネータ
    class Coordinator: NSObject, WKNavigationDelegate {
        var isInitialLoad = true // 初回ロード判定用のフラグ
        @Binding var isLoading: LoadingStatus

        init(isLoading: Binding<LoadingStatus>) {
            _isLoading = isLoading
        }
        // 成功
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.isLoading = .success // ロード完了時にプレースホルダー非表示
        }
        // 失敗
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.isLoading = .failure(error) // エラー時にもプレースホルダー非表示
        }
    }
}

#Preview {
    Video(videoID: "", isLoading: .constant(.idle))
}
