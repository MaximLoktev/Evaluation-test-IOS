//
//  AlbumsFeedSearchController.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//

import UIKit

final class AlbumsFeedSearchController: UISearchController, UISearchBarDelegate, UISearchResultsUpdating {
    
    // MARK: - Properties

    var onAlbumsSearch: ((String) -> Void)?
    
    var onCancelClicked: (() -> Void)?
    
    // MARK: - Init
    
    init() {
        super.init(searchResultsController: nil)

        obscuresBackgroundDuringPresentation = false
        searchBar.tintColor = .white
        searchBar.barStyle = .black
        searchBar.placeholder = NSLocalizedString("Поиск", comment: "")
        searchBar.delegate = self
        searchResultsUpdater = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        onCancelClicked?()
    }
    
    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(reloadSearchResults(_:)),
                                               object: searchController.searchBar)
        
        perform(#selector(reloadSearchResults(_:)), with: searchBar, afterDelay: 0.5)
    }
    
    @objc
    private func reloadSearchResults(_ sender: UISearchBar) {
        guard let text = sender.text, !text.isEmpty else {
            return
        }
        
        onAlbumsSearch?(text.lowercased())
    }
}

