//
//  AlbumsDetailInteractor.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol AlbumsDetailBusinessLogic {
    func load(request: AlbumsDetailDataFlow.Load.Request)
}

final class AlbumsDetailInteractor: AlbumsDetailBusinessLogic {

    // MARK: - Properties

    var presenter: AlbumsDetailPresentationLogic?
    
    private let album: AlbumModel
    
    private let albumService: AlbumService
    
    // MARK: - Init
    
    init(album: AlbumModel, albumService: AlbumService) {
        self.album = album
        self.albumService = albumService
    }
    
    // MARK: - AlbumsDetailBusinessLogic

    func load(request: AlbumsDetailDataFlow.Load.Request) {
        albumService.getSongsFromAlbum(nameAlbum: album.collectionName) { [weak self] result in
            let response: AlbumsDetailDataFlow.Load.Response
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let songs):
                response = .success(album: self.album, songs: songs)
            case .failure(let error):
                response = .failure(error: error)
            }
            self.presenter?.presentLoad(response: response)
        }
    }
}
