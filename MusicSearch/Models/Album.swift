//
//  Album.swift
//  MusicSearch
//
//  Created by Omar Yousef on 2021-09-25.
//

import Foundation

struct Albums: Codable{
    var results: [Album]
}

struct Album: Codable{
    var collectionName: String?
    var trackName: String?
    var artistName: String?
    var trackPrice: Double?
    var wrapperType: String?
    var trackExplicitness: String?
    var collectionViewURL: String?
}
