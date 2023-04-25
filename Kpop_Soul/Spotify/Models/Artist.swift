//
//  Artist.swift
//  Spotify
//
//  Created by biubiubiu on 2023/4/11.
//

import Foundation

struct ImageObject:Decodable {
    let url: URL
    let width: Int
    let height: Int
}

struct Artist: Decodable {
    
    let id: String
    let images: [ImageObject]
    let name: String?
}

struct SearchResponse: Decodable {
    let artists: Artists
}

struct Artists: Decodable {
    let items: [Artist]
}
