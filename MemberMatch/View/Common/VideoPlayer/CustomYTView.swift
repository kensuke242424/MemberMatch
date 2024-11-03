//
//  YTView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/10/28.
//

import SwiftUI

struct CustomYTView: View {
    let urlString: String

    @State private var isLoading: LoadingStatus = .idle

    var body: some View {
        if urlString.isEmpty {
            placeHolderYTView(iconName: Constants.Symbols.play_fill,
                              text: Constants.Strings.isEmptyVideoUrlText,
                              textColor: .gray,
                              isLoading: false
            )
        } else if let videoID = getYTVideoID(urlString) {
            createYTView(videoID: videoID, isLoading: $isLoading)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.ytVideoHeight)
                .onAppear {
                    self.isLoading = .loading
                }
                .onChange(of: videoID) { [oldValue = videoID] newValue in
                    if oldValue != newValue {
                        self.isLoading = .loading
                    }
                }
        } else {
            placeHolderYTView(iconName: Constants.Symbols.play_slash_fill,
                              text: Constants.Strings.isFailedVideoUrlText,
                              textColor: .red,
                              isLoading: false
            )
        }
    }

    @ViewBuilder
    func createYTView(videoID: String, isLoading: Binding<LoadingStatus>) -> some View {
        ZStack {
            Video(videoID: videoID, isLoading: $isLoading)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.ytVideoHeight)

            switch isLoading.wrappedValue {
            case .idle: EmptyView()

            case .loading:
                placeHolderYTView(iconName: Constants.Symbols.play_fill,
                                  text: Constants.Strings.isLoadingVideoText,
                                  textColor: .gray,
                                  isLoading: true
                )

            case .success: EmptyView()

            case .failure(_):
                placeHolderYTView(iconName: Constants.Symbols.play_slash_fill,
                                  text: Constants.Strings.isFailedVideoUrlText,
                                  textColor: .red,
                                  isLoading: false
                )
            }
        }
    }

    @ViewBuilder
    private func placeHolderYTView(iconName: String, text: String, textColor: Color, isLoading: Bool) -> some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: Constants.ytVideoHeight)
                .foregroundStyle(.white.gradient)
                .cornerRadius(10)

            Group {
                if isLoading {
                    ProgressView()
                        .tint(.black)
                } else {
                    Image(systemName: iconName)
                        .foregroundStyle(.gray.opacity(0.7))
                }
            }
            .font(.largeTitle)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                Text(text)
                    .font(.callout)
                    .tracking(4)
                    .foregroundStyle(textColor.opacity(0.7))
                    .offset(y: -40)
            }
        }
    }

    // YouTubeのURLから動画IDを抽出する関数
    private func getYTVideoID(_ urlString: String) -> String? {
        guard let url = URL(string: urlString) else { return nil }

        // www.youtube.comまたはyoutube.comのURLの場合
        if url.host == "www.youtube.com" || url.host == "youtube.com" {
            return URLComponents(url: url, resolvingAgainstBaseURL: false)?
                .queryItems?
                .first { $0.name == "v" }?
                .value
        }
        // youtu.beの短縮URLの場合
        if url.host == "youtu.be" {
            return url.lastPathComponent
        }

        return nil
    }
}

#Preview {
    CustomYTView(urlString: "")
}
