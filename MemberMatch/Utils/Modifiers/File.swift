//
//  File.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/06/16.
//

import SwiftUI

struct EditingScaleEffect: ViewModifier {
    @Binding var isEditing: Bool
    var scaleAmount: CGFloat = 1.01

    func body(content: Content) -> some View {
        content
            .scaleEffect(isEditing ? scaleAmount : 1)
            .animation(.easeInOut(duration: 0.3), value: isEditing)
    }
}

extension View {
    func editingScaleEffect(isEditing: Binding<Bool>, scaleAmount: CGFloat = 1.01) -> some View {
        self.modifier(EditingScaleEffect(isEditing: isEditing, scaleAmount: scaleAmount))
    }
}
