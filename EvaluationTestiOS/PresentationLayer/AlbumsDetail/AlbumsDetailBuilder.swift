//
//  AlbumsDetailBuilder.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AlbumsDetailBuildable {
    func build(withModuleOutput output: AlbumsDetailModuleOutput, album: AlbumModel) -> UIViewController & AlbumsDetailModuleInput
}

final class AlbumsDetailBuilder: AlbumsDetailBuildable {

    // MARK: - Properties
    
    private let albumService: AlbumService
    
    // MARK: - Init

    init(albumService: AlbumService) {
        self.albumService = albumService
    }

    // MARK: - AlbumsDetailBuildable
    
    func build(withModuleOutput output: AlbumsDetailModuleOutput, album: AlbumModel) -> UIViewController & AlbumsDetailModuleInput {
        let viewController = AlbumsDetailViewController()
        let interactor = AlbumsDetailInteractor(album: album, albumService: albumService)
        let presenter = AlbumsDetailPresenter()
        viewController.interactor = interactor
        viewController.moduleOutput = output
        interactor.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }

}
