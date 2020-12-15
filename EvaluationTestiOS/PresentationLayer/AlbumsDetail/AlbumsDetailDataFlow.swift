//
//  AlbumsDetailDataFlow.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum AlbumsDetailDataFlow {
    
    enum Item {
        case album(album: AlbumModel)
        case song(song: SongModel)
    }
    
    enum Load {

        struct Request { }

        enum Response {
            case success(album: AlbumModel, songs: [SongModel])
            case failure(error: APIError)
        }
        
        enum ViewModel {
            case success(items: [Item])
            case failure(title: String, description: String)
        }
    }
}
