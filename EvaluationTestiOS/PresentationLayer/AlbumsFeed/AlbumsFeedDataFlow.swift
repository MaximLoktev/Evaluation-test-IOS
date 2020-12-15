//
//  AlbumsFeedDataFlow.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum AlbumsFeedDataFlow {
    
    enum Item {
        case message(title: String)
        case album(album: AlbumModel)
        case loading
    }
    
    enum Load {

        struct Request { }

        struct Response { }

        struct ViewModel {
            let items: [Item]
        }
        
    }
    
    enum NameInput {

        struct Request {
            let name: String
        }

        enum Response {
            case success(albums: [AlbumModel])
            case failure(error: APIError)
        }

        enum ViewModel {
            case success(items: [Item])
            case failure(title: String, description: String)
        }
        
    }
    
    enum LoadingAlbums {

        struct Request { }

        struct Response { }

        struct ViewModel {
            let items: [Item]
        }
        
    }
    
    enum UpdateStatus {
        
        struct Request { }
        
        struct Response { }
        
        struct ViewModel {
            let items: [Item]
        }
    }
    
    enum SelectAlbum {
        
        struct Request {
            let index: Int
        }

        struct Response {
            let album: AlbumModel
        }
        
        struct ViewModel {
            let album: AlbumModel
        }
    }
}
