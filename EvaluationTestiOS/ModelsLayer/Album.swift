//
//  Album.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import Foundation

struct AlbumModel {
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl60: String
    let artworkUrl100: String
    let trackCount: Int
    let copyright: String
    let releaseDate: String
    let primaryGenreName: String
}

struct SongModel {
    let trackName: String
    let trackNumber: Int
    let trackTimeMillis: Int
}
