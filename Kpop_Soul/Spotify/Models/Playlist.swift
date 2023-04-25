//
//  Playlist.swift
//  Spotify
//
//  Created by biubiubiu on 2023/4/11.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
