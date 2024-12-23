//
//  SnapCarouselImageView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/11/17.
//

import SDWebImageSwiftUI
import SwiftUI

struct SnapCarouselImageView: View {
    @Binding var isShow: Bool
    @Binding var selectionIndex: Int
    var images: [ImageData]

    @State private var previewImageUrl: String?

    let l10n = Constants.Strings.self

    var body: some View {
        VStack(spacing: 0) {
            TabTopBarView(
                "GALLERY",
                showBackground: .constant(false),
                leftToolbarItems: {},
                rightToolbarItems: {
                    Button("閉じる") {
                        withAnimation { isShow.toggle() }
                    }
                }
            )
            GeometryReader {
                let size = $0.size

                if let imageUrl = previewImageUrl {
                    WebImage(url: URL(string: imageUrl)) {image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: size.width, height: size.height)
                            .clipped()
                    } placeholder: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black.opacity(0.2))
                                .frame(width: size.width, height: size.height)
                            ProgressView()
                        }
                    }
                }
            }
            .onChange(of: selectionIndex) { newValue in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.previewImageUrl = images[selectionIndex].url
                }
            }
            .padding(.vertical, 15)

            GeometryReader {
                let size = $0.size
                let pageWidth: CGFloat = size.width / 3
                let imageWidth: CGFloat = 120

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(images, id: \.self.url) { image in
                            ZStack {
                                WebImage(url: URL(string: image.url)) {image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: imageWidth, height: size.height)
                                        .clipped()
                                        .onChange(of: selectionIndex) { newValue in
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                self.previewImageUrl = images[selectionIndex].url
                                            }
                                        }
                                } placeholder: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(.black.opacity(0.2))
                                            .frame(width: imageWidth, height: size.height)
                                        ProgressView()
                                    }
                                }
                            }
                            .frame(width: pageWidth, height: size.height)
                        }
                    }
                    // 写真の両端がスクロール限界時に画面中央に来るよう設定
                    .padding(.horizontal, (size.width - pageWidth) / 2)
                    .background {
                        SnapCarouselHelper(pageWidth: pageWidth, pageCount: images.count, index: $selectionIndex)
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(.white, lineWidth: 3.5)
                        .frame(width: imageWidth, height: size.height)
                }
            }
            .frame(height: 100)
            .padding(.bottom, 10)
        }
        .background {
            LinearGradient(
                gradient: Gradient(colors: [
                    .black,
                    .customDarkGray
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .opacity(0.96)
        }
        .task {
            if images.isEmpty { return }
            previewImageUrl = images[selectionIndex].url
        }
    }
}

#Preview {
    SnapCarouselImageView(isShow: .constant(true), selectionIndex: .constant(0), images: MockImageData.dataList)
        .preferredColorScheme(.dark)
}
