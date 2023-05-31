//
//  GalleryModel.swift
//  Gamer Hub
//
//  Created by Halil Oğuz on 25.05.2023.
//

import Foundation

struct GallerySearchModel: Codable {
    let results: [Search]
    let next: String?
}

struct Search: Codable {
    let name: String?
    let background_image: String?
}
