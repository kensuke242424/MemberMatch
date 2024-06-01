//
//  RecruitmentDetailViewModel.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/19.
//

import SwiftUI

class RecruitmentDetailViewModel: ObservableObject {
    @Published var collapseProgress: CGFloat = .zero {
        didSet {
            self.handleScrolledPoint(newValue: collapseProgress)
        }
    }

    @Published var isResetScroll: Bool = false
    @Published var isShowTopBarBackground: Bool = false
    @Published var isOpenHeaderContents: Bool = false
    @Published var isScrolledStartPoint: Bool = false
    @Published var isScrolledMidPoint: Bool = false
    @Published var isScrolledEndPoint: Bool = false
    @Published var isAlreadyShown: Bool = false
    @Published var isFixedCard: Bool = false
    @Published var recruitmentCardSize: CGSize = .zero
    @Published var maxHeaderHeight: CGFloat = .zero
    var minHeaderHeight: CGFloat {
        self.isFixedCard ? 160 : 0
    }

    let toolBarHeight: CGFloat = 100

    func handleScrolledPoint(newValue: CGFloat) {
        //MEMO: 最初のスクロール時、最初期値として1.0が出力されるため、弾く
        if newValue == 1.0 { return }

        if newValue > 0.1 {
            withAnimation(.spring(duration: 0.3)) { isScrolledStartPoint = true }
        } else {
            withAnimation(.spring(duration: 0.3)) { isScrolledStartPoint = false }
        }
        if newValue > 0.5 {
            withAnimation(.spring(duration: 0.3)) { isScrolledMidPoint = true }
        } else {
            withAnimation(.spring(duration: 0.3)) { isScrolledMidPoint = false }
        }
        if newValue > 0.9 {
            withAnimation(.spring(duration: 0.3)) { isScrolledEndPoint = true }
        } else {
            withAnimation(.spring(duration: 0.3)) { isScrolledEndPoint = false }
        }
    }

    func resetScrollToTop() {
        isResetScroll = true
    }
}
