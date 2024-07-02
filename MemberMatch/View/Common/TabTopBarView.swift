//
//  TabTopBarView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/19.
//

import SwiftUI

struct TabTopBarView<LeftItems: View, RightItems: View>: View {
    let title: String?
    @Binding var showBackground: Bool
    let leftToolbarItems: LeftItems
    let rightToolbarItems: RightItems

    init(
        _ title: String?,
        showBackground: Binding<Bool> = .constant(true),
        @ViewBuilder leftToolbarItems: () -> LeftItems,
        @ViewBuilder rightToolbarItems: () -> RightItems
    ) {
        self.title = title
        self._showBackground = showBackground
        self.leftToolbarItems = leftToolbarItems()
        self.rightToolbarItems = rightToolbarItems()
    }

    let iconSize: CGFloat = 30
    let toolBarHeight: CGFloat = 100

    var body: some View {
        HStack {
            Text(NSLocalizedString(title ?? "", comment: title ?? ""))
                .tracking(1)
                .lineLimit(1)
                .fontWeight(.semibold)
                .contentShape(Rectangle())
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            // Replace with your ViewModel method
            // vm.resetScrollToTop()
        }
        .overlay {
            HStack(spacing: 12) {
                leftToolbarItems
                Spacer()
                rightToolbarItems
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 60)
        .frame(height: toolBarHeight)
        .background(
            showBackground ? Color.clear.overlay {
                BlurView(style: .systemUltraThinMaterial).ignoresSafeArea(edges: .top)
            } : nil
        )
    }
}

#Preview {
    TabTopBarView(
        "test",
        leftToolbarItems: {
            VStack {}
        }, rightToolbarItems: {
            VStack {}
        }
    )
}
