//
//  Artist.swift
//  Spotify
//
//  Created by biubiubiu on 2023/4/11.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
