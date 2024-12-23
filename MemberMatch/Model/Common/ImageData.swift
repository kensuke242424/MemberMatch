//
//  ImageData.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/06.
//

import Foundation

struct ImageData: Codable, Equatable, Hashable {
    var url: String
    var path: String
}

let mockImagesData: [ImageData] = [
    .init(url: "https://via.placeholder.com/600x400.png?text=Sample+Image+1", path: ""),
    .init(url: "https://via.placeholder.com/600x400.png?text=Sample+Image+2", path: ""),
    .init(url: "https://via.placeholder.com/600x400.png?text=Sample+Image+3", path: ""),
    .init(url: "https://via.placeholder.com/600x400.png?text=Sample+Image+4", path: ""),
    .init(url: "https://via.placeholder.com/600x400.png?text=Sample+Image+5", path: "")
]
