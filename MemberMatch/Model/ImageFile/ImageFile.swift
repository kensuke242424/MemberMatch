//
//  ImageFile.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/11/17.
//

import UIKit

struct ImageFile: Identifiable {
    var id: UUID = .init()
    var imageName: String
    var thumbnail: UIImage?
}
