//
//  ToastView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/11/16.
//

import SwiftUI

struct ToastView: View {
    var message: String
    var backGroundColor: Color
    var foregroundColor: Color

    var body: some View {
        Text(message)
            .padding()
            .background(backGroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(8)
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            .background(Color.clear) // 背景透過
    }
}

#Preview {
    VStack{
        ToastView(message: "条件を満たせていない項目があります。",
                  backGroundColor: Color.red,
                  foregroundColor: Color.white
        )
        Spacer()
    }
}
