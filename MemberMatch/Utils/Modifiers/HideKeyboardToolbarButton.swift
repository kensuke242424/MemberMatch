//
//  HydeKeyboardToolbarButton.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/06.
//

import SwiftUI

struct HideKeyboardToolbarButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                    } label: {
                        Image(systemName: Constants.Symbols.chevron_down)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 60)
                            .background {
                                Capsule().foregroundStyle(.blue.gradient)
                            }
                    }
                }
            }
    }
}

extension View {
    func hideKeyboardToolbarButton() -> some View {
        self.modifier(HideKeyboardToolbarButtonModifier())
    }
}
