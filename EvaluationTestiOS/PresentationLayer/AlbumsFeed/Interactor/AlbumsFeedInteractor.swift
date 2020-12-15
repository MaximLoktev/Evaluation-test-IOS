//
//  AlbumsFeedInteractor.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol AlbumsFeedBusinessLogic {
    func load(request: AlbumsFeedDataFlow.Load.Request)
    func nameInput(request: AlbumsFeedDataFlow.NameInput.Request)
    func updateStatus(request: AlbumsFeedDataFlow.UpdateStatus.Request)
    func selectAlbum(request: AlbumsFeedDataFlow.SelectAlbum.Request)
}

final class AlbumsFeedInteractor: AlbumsFeedBusinessLogic {

    // MARK: - Properties

    var presenter: AlbumsFeedPresentationLogic?
    
    private var albums: [AlbumModel] = []
    
    private let albumService: AlbumService
    
    // MARK: - Init
    
    init(albumService: AlbumService) {
        self.albumService = albumService
    }
    
    // MARK: - AlbumsFeedBusinessLogic
    
    func load(request: AlbumsFeedDataFlow.Load.Request) {
        let response = AlbumsFeedDataFlow.Load.Response()
        presenter?.presentLoad(response: response)
    }
    
    func nameInput(request: AlbumsFeedDataFlow.NameInput.Request) {
        albumService.getAlbums(name: request.name) { [weak self] result in
            let response: AlbumsFeedDataFlow.NameInput.Response
            
            switch result {
            case.success(let albumsArray):
                self?.albums = albumsArray
                response = .success(albums: albumsArray)
            case.failure(let error):
                response = .failure(error: error)
            }
            
            self?.presenter?.presentNameInput(response: response)
        }
        
        let response = AlbumsFeedDataFlow.LoadingAlbums.Response()
        presenter?.presentLoadingAlbums(response: response)
    }
    
    func updateStatus(request: AlbumsFeedDataFlow.UpdateStatus.Request) {
        if albums.isEmpty {
            let response = AlbumsFeedDataFlow.UpdateStatus.Response()
            presenter?.presentUpdateStatus(response: response)
        }
    }
    
    func selectAlbum(request: AlbumsFeedDataFlow.SelectAlbum.Request) {
        let album = albums[request.index]
        let response = AlbumsFeedDataFlow.SelectAlbum.Response(album: album)
        presenter?.presentSelectAlbum(response: response)
    }
}
