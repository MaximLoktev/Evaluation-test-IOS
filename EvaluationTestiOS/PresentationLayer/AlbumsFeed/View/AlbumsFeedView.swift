//
//  AlbumsFeedView.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import SnapKit

protocol AlbumsFeedViewDelegate: class {

}

final class AlbumsFeedView: UIView {

    // MARK: - Properties

    weak var delegate: AlbumsFeedViewDelegate?
    
    private let collectionView = AlbumsFeedCollectionView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        addSubview(collectionView)
        
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup

    func setupLoad(viewModel: AlbumsFeedDataFlow.Load.ViewModel) {

    }
    
    func setupDataManager(dataManager: UICollectionViewDataSource & UICollectionViewDelegate) {
        collectionView.delegate = dataManager
        collectionView.dataSource = dataManager
        collectionView.reloadData()
    }
    
    // MARK: - Layout
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }    
}
