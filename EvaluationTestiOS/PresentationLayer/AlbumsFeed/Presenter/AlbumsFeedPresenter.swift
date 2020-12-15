//
//  AlbumsFeedPresenter.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol AlbumsFeedPresentationLogic {
    func presentLoad(response: AlbumsFeedDataFlow.Load.Response)
    func presentNameInput(response: AlbumsFeedDataFlow.NameInput.Response)
    func presentLoadingAlbums(response: AlbumsFeedDataFlow.LoadingAlbums.Response)
    func presentUpdateStatus(response: AlbumsFeedDataFlow.UpdateStatus.Response)
    func presentSelectAlbum(response: AlbumsFeedDataFlow.SelectAlbum.Response)
}

final class AlbumsFeedPresenter: AlbumsFeedPresentationLogic {

    // MARK: - Properties
    
    weak var viewController: AlbumsFeedControllerLogic?

    // MARK: - AlbumsFeedPresentationLogic
    
    func presentLoad(response: AlbumsFeedDataFlow.Load.Response) {
        let title = NSLocalizedString("Введите исполнителя, альбом\n в поисковой строке", comment: "")
        let items: [AlbumsFeedDataFlow.Item] = makeMessageItem(title: title)
        
        let viewModel = AlbumsFeedDataFlow.Load.ViewModel(items: items)
        viewController?.displayLoad(viewModel: viewModel)
    }
    
    func presentNameInput(response: AlbumsFeedDataFlow.NameInput.Response) {
        let viewModel: AlbumsFeedDataFlow.NameInput.ViewModel
        
        switch response {
        case .success(let albums):
            let items: [AlbumsFeedDataFlow.Item]
            
            if !albums.isEmpty {
                items = makeItems(albums: albums)
            } else {
                let title = NSLocalizedString("По данному запросу ничего\n не найдено", comment: "")
                items = makeMessageItem(title: title)
            }
            viewModel = .success(items: items)
        case .failure:
            viewModel = .failure(title: NSLocalizedString("Ошибка", comment: ""),
                                 description: NSLocalizedString("Не удалось загрузить данные", comment: ""))
        }
        
        viewController?.displayNameInput(viewModel: viewModel)
    }
    
    func presentLoadingAlbums(response: AlbumsFeedDataFlow.LoadingAlbums.Response) {
        let viewModel = AlbumsFeedDataFlow.LoadingAlbums.ViewModel(items: [.loading])
        viewController?.displayLoadingAlbums(viewModel: viewModel)
    }
    
    func presentUpdateStatus(response: AlbumsFeedDataFlow.UpdateStatus.Response) {
        let title = NSLocalizedString("Введите исполнителя, альбом\n в поисковой строке", comment: "")
        let items: [AlbumsFeedDataFlow.Item] = makeMessageItem(title: title)
        let viewModel = AlbumsFeedDataFlow.UpdateStatus.ViewModel(items: items)
        viewController?.displayUpdateStatus(viewModel: viewModel)
    }
    
    func presentSelectAlbum(response: AlbumsFeedDataFlow.SelectAlbum.Response) {
        let viewModel = AlbumsFeedDataFlow.SelectAlbum.ViewModel(album: response.album)
        viewController?.displaySelectAlbum(viewModel: viewModel)
    }
    
    private func makeItems(albums: [AlbumModel]) -> [AlbumsFeedDataFlow.Item] {
        let albums: [AlbumsFeedDataFlow.Item] = albums.map { album in
            AlbumsFeedDataFlow.Item.album(album: album)
        }
        return albums
    }
    
    private func makeMessageItem(title: String) -> [AlbumsFeedDataFlow.Item] {
        var items: [AlbumsFeedDataFlow.Item] = []
        items.append(.message(title: title))
        
        return items
    }
}
