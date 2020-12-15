//
//  AlbumsFeedCollectionView.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import UIKit

final class AlbumsFeedCollectionView: UICollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = .zero
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .clear
        
        contentInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        showsHorizontalScrollIndicator = false
        alwaysBounceVertical = true
        
        register(cellClass: AlbumsFeedCell.self)
        register(cellClass: AlbumsInfoCell.self)
        register(cellClass: AlbumsActivityCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
