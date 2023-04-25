//
//  Album.swift
//  Spotify
//
//  Created by Derrick Ng on 4/21/23.
//

import Foundation

struct Album: Decodable {
    let id: String?
    let name: String?
    let images: [Image]
}

struct Image: Decodable {
    let url: URL
    let width: Int
    let height: Int
}

struct AlbumSearchResponse: Decodable {
    let albums: [Album]
}
