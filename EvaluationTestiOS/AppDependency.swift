//
//  AppDependency.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import Moya

protocol RootDependency {
    var albumService: AlbumService { get }
    var albumProvider: MoyaProvider<API.Album> { get }
}

final class AppDependency: RootDependency {
    
    private(set) lazy var albumProvider: MoyaProvider<API.Album> = MoyaProvider<API.Album>()
    
    private(set) lazy var albumService: AlbumService = AlbumServiceImpl(provider: albumProvider)
    
}
