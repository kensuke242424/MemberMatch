//
//  UIDevice.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/05/18.
//

import Foundation
import UIKit

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.compactMap { element in
            element.value as? Int8
        }.filter { $0 != 0 }.map { String(Character(UnicodeScalar(UInt8($0)))) }.joined()

        print(identifier)
        switch identifier {
        case "iPhone14,2": return "iPhone 13 Pro"
        case "iPhone14,3": return "iPhone 13 Pro Max"
        case "iPhone14,4": return "iPhone 13 mini"
        case "iPhone14,5": return "iPhone 13"
        case "iPhone15,2": return "iPhone 14 Pro"
        case "iPhone15,3": return "iPhone 14 Pro Max"
        case "iPhone15,4": return "iPhone 14"
        case "iPhone15,5": return "iPhone 14 Plus"
        case "iPhone15,6": return "iPhone 15 Pro"
        case "iPhone15,7": return "iPhone 15 Pro Max"
        case "iPhone15,8": return "iPhone 15"
        case "iPhone15,9": return "iPhone 15 Plus"
            // 他のモデルについてはここに追加
        default: return identifier
        }
    }
}
