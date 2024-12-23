//
//  SnapCarouselHelper.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/11/17.
//

import SwiftUI

struct SnapCarouselHelper: UIViewRepresentable {
    var pageWidth: CGFloat
    var pageCount: Int
    @Binding var index: Int

    @State private var isShowing: Bool = false

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async { [weak uiView] in
            guard let uiView = uiView else { return }
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView {
                scrollView.decelerationRate = .fast
                scrollView.delegate = context.coordinator
                context.coordinator.pageWidth = pageWidth
                context.coordinator.pageCount = pageCount
                if !isShowing {
                    isShowing = true
                    context.coordinator.attach(scrollView: scrollView)
                    // 選択された画像にスクロールを動かす
                    context.coordinator.scrollToPage(index: index, animated: false)
                }
            }
        }
    }

    /*
     Coordinator クラスの初期値はそれを初期化するために使用されるため、
     struct の内容が更新されても、Coordinatorクラス自体は更新されません。
     Coordinator クラスでは、pageCount と pageWidth用の個別の変数を作成し、
     それらを updateUIView() メソッド内で更新する必要があります。
     */
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: SnapCarouselHelper
        var pageWidth: CGFloat = 0
        var pageCount: Int = 0
        private weak var scrollView: UIScrollView? // UIScrollViewを保持

        init(parent: SnapCarouselHelper) {
            self.parent = parent
        }

        // スクロールが発生した際に呼び出される
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // スクロール位置（X軸方向のオフセット）をデバッグ用に出力
            //            print(scrollView.contentOffset.x)
        }

        // ドラッグ操作が終了し、スクロール速度とターゲット位置が決定する際に呼び出される
        func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                       withVelocity velocity: CGPoint,
                                       targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            // スクロール終了時の最終的なX位置を予測（現在位置 + 速度×補正値）
            let targetEnd = scrollView.contentOffset.x + (velocity.x * 60)

            // ページ幅で割り、四捨五入して最も近いページインデックスを計算
            let targetIndex = (targetEnd / pageWidth).rounded()

            let index = min(max(Int(targetIndex), 0), pageCount - 1)
            parent.index = index

            // ターゲットのスクロール位置をページ幅に基づく値に調整し、スナップ動作を実現
            targetContentOffset.pointee.x = targetIndex * pageWidth
        }

        // UIScrollViewの参照を設定する
        func attach(scrollView: UIScrollView) {
            self.scrollView = scrollView
        }

        // スクロール位置を明示的に動かす
        func scrollToPage(index: Int, animated: Bool) {
            guard let scrollView = scrollView else { return }
            let targetOffset = CGFloat(index) * pageWidth
            scrollView.setContentOffset(CGPoint(x: targetOffset, y: 0), animated: animated)
        }
    }
}

#Preview {
    SnapCarouselImageView(isShow: .constant(true), selectionIndex: .constant(0), images: mockImagesData)
}
