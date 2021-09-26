//
//  Album.swift
//  MusicSearch
//
//  Created by Omar Yousef on 2021-09-25.
//

import Foundation


//All albums
struct Albums: Codable{
    var results: [Album]
}

//Album object to create a new instance of the object
struct Album: Codable{
    var collectionName: String?
    var trackName: String?
    var artistName: String?
    var trackPrice: Double?
    var wrapperType: String?
    var trackExplicitness: String?
    var artworkUrl100: String?
}
