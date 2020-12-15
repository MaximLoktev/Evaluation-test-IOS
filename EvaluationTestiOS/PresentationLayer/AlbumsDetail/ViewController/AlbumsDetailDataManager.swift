//
//  AlbumsDetailDataManager.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//

import UIKit

final class AlbumsDetailDataManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    var items: [AlbumsDetailDataFlow.Item] = []
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.item]
        
        switch item {
        case .album(let album):
            let cell = tableView.dequeueReusableCell(withClass: AlbumsDetailCell.self, forIndexPath: indexPath)
            cell.setupCell(album: album)
            return cell
        case .song(let song):
            let cell = tableView.dequeueReusableCell(withClass: AlbumsSongsCell.self, forIndexPath: indexPath)
            cell.setupCell(song: song, index: indexPath.row)
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.item]
        
        switch item {
        case .album:
            return 108.0
        case .song:
            return 64.0
        }
    }
}
