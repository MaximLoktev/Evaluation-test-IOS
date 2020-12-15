//
//  AlbumsFeedDataManager.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import UIKit

final class AlbumsFeedDataManager: NSObject, UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    enum Constants {
        static let widthCell: CGFloat = (UIScreen.main.bounds.width) / 2.3
        static let height: CGFloat = 100
    }
    
    var items: [AlbumsFeedDataFlow.Item] = []
    
    var onSelectAlbum: ((Int) -> Void)?
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = items[indexPath.row]
        
        switch item {
        case .message(let title):
            let cell = collectionView.dequeueReusableCell(withClass: AlbumsInfoCell.self, forIndexPath: indexPath)
            cell.setupTitle(title: title)
            return cell
        case .album(let album):
            let cell = collectionView.dequeueReusableCell(withClass: AlbumsFeedCell.self, forIndexPath: indexPath)
            cell.setupCell(album: album)
            return cell
        case .loading:
            let cell = collectionView.dequeueReusableCell(withClass: AlbumsActivityCell.self, forIndexPath: indexPath)
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        
        if case .album = item {
            onSelectAlbum?(indexPath.row)
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = items[indexPath.item]
        
        switch item {
        case .message, .loading:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: Constants.widthCell)
        case .album:
            return CGSize(width: Constants.widthCell,
                          height: Constants.widthCell + Constants.height)
        }
    }
}
