//
//  AlbumsFeedBuilder.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AlbumsFeedBuildable {
    func build(withModuleOutput output: AlbumsFeedModuleOutput) -> UIViewController & AlbumsFeedModuleInput
}

final class AlbumsFeedBuilder: AlbumsFeedBuildable {

    // MARK: - Properties
    
    private let albumService: AlbumService

    // MARK: - Init

    init(albumService: AlbumService) {
        self.albumService = albumService
    }

    // MARK: - AlbumsFeedBuildable
    
    func build(withModuleOutput output: AlbumsFeedModuleOutput) -> UIViewController & AlbumsFeedModuleInput {
        let viewController = AlbumsFeedViewController()
        let interactor = AlbumsFeedInteractor(albumService: albumService)
        let presenter = AlbumsFeedPresenter()
        viewController.interactor = interactor
        viewController.moduleOutput = output
        interactor.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
}
