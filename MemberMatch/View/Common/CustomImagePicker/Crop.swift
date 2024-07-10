//
//  Crop.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/10.
//

import Foundation

// MARK: Crop Config

enum Crop: Equatable {
    case circle
    case rectangle
    case square
    case custom(CGSize)

    func name() -> String {
        switch self {
        case .circle:
            return "Circle"
        case .rectangle:
            return "Rectangle"
        case .square:
            return "Square"
        case let .custom(cGSize):
            return "Custom \(Int(cGSize.width))X\(Int(cGSize.height))"
        }
    }

    func size() -> CGSize {
        switch self {
        case .circle:
            return .init(width: 300, height: 300)
        case .rectangle:
            return .init(width: ScreenUtil.deviceWidth, height: ScreenUtil.deviceWidth * 2 / 3)
        case .square:
            return .init(width: 300, height: 300)
        case .custom(let cgSize):
            return cgSize
        }
    }
}
