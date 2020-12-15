//
//  AlbumsDetailView.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AlbumsDetailViewDelegate: class {

}

final class AlbumsDetailView: UIView {

    // MARK: - Properties

    weak var delegate: AlbumsDetailViewDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .darkGray
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
        
        tableView.register(cellClass: AlbumsDetailCell.self)
        tableView.register(cellClass: AlbumsSongsCell.self)
        
        return tableView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        addSubview(tableView)
        
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup

    func setupLoad(viewModel: AlbumsDetailDataFlow.Load.ViewModel) {

    }
    
    func setupDataManager(dataManager: UITableViewDataSource & UITableViewDelegate) {
        tableView.dataSource = dataManager
        tableView.delegate = dataManager
        tableView.reloadData()
    }
    
    // MARK: - Layout
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
