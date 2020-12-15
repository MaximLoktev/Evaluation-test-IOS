//
//  AlbumsDetailPresenter.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol AlbumsDetailPresentationLogic {
    func presentLoad(response: AlbumsDetailDataFlow.Load.Response)
}

final class AlbumsDetailPresenter: AlbumsDetailPresentationLogic {

    // MARK: - Properties
    
    weak var viewController: AlbumsDetailControllerLogic?

    // MARK: - AlbumsDetailPresentationLogic

    func presentLoad(response: AlbumsDetailDataFlow.Load.Response) {
        let viewModel: AlbumsDetailDataFlow.Load.ViewModel
        
        switch response {
        case let .success(album, songs):
            let items: [AlbumsDetailDataFlow.Item] = makeItem(album: album, songs: songs)
            viewModel = .success(items: items)
        case .failure:
            viewModel = .failure(title: NSLocalizedString("Ошибка", comment: ""),
                                 description: NSLocalizedString("Не удалось загрузить альбом", comment: ""))
        }
        viewController?.displayLoad(viewModel: viewModel)
    }
    
    private func makeItem(album: AlbumModel, songs: [SongModel]) -> [AlbumsDetailDataFlow.Item] {
        var items: [AlbumsDetailDataFlow.Item] = []
        items.append(.album(album: album))
        
        let songs = songs.map { song in
            AlbumsDetailDataFlow.Item.song(song: song)
        }
        items.append(contentsOf: songs)
        
        return items
    }

}
