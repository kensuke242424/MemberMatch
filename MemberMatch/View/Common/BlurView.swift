//
//  BlurView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/12.
//

import SwiftUI

// Since App Supports iOS 14...
struct BlurView: UIViewRepresentable {

    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))

        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // NOP
    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView(style: .systemChromeMaterialDark)
    }
}
