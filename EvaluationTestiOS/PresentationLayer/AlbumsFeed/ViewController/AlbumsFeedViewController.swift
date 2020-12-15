//
//  AlbumsFeedViewController.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AlbumsFeedControllerLogic: class {
    func displayLoad(viewModel: AlbumsFeedDataFlow.Load.ViewModel)
    func displayNameInput(viewModel: AlbumsFeedDataFlow.NameInput.ViewModel)
    func displayLoadingAlbums(viewModel: AlbumsFeedDataFlow.LoadingAlbums.ViewModel)
    func displayUpdateStatus(viewModel: AlbumsFeedDataFlow.UpdateStatus.ViewModel)
    func displaySelectAlbum(viewModel: AlbumsFeedDataFlow.SelectAlbum.ViewModel)
}

protocol AlbumsFeedModuleOutput: class {
    func albumsFeedModuleDidShowAlbumsDetail(album: AlbumModel)
}

protocol AlbumsFeedModuleInput: class {

}

final class AlbumsFeedViewController: UIViewController,
    AlbumsFeedControllerLogic, AlbumsFeedModuleInput, AlbumsFeedViewDelegate {

    // MARK: - Properties

    var interactor: AlbumsFeedBusinessLogic?

    weak var moduleOutput: AlbumsFeedModuleOutput?

    var moduleView: AlbumsFeedView!
    
    private let dataManager = AlbumsFeedDataManager()
    
    private let searchController = AlbumsFeedSearchController()

    // MARK: - View life cycle

    override func loadView() {
        moduleView = AlbumsFeedView(frame: UIScreen.main.bounds)
        moduleView.delegate = self
        view = moduleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Список Альбомов", comment: "")
        navigationItem.searchController = searchController
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        
        searchController.onAlbumsSearch = { [weak self] name in
            let request = AlbumsFeedDataFlow.NameInput.Request(name: name)
            self?.interactor?.nameInput(request: request)
        }
        
        searchController.onCancelClicked = { [weak self] in
            let request = AlbumsFeedDataFlow.UpdateStatus.Request()
            self?.interactor?.updateStatus(request: request)
        }
        
        dataManager.onSelectAlbum = { [weak self] index in
            let request = AlbumsFeedDataFlow.SelectAlbum.Request(index: index)
            self?.interactor?.selectAlbum(request: request)
        }
        
        startLoading()
    }

    // MARK: - AlbumsFeedControllerLogic

    private func startLoading() {
        let request = AlbumsFeedDataFlow.Load.Request()
        interactor?.load(request: request)
    }
    
    func displayLoad(viewModel: AlbumsFeedDataFlow.Load.ViewModel) {
        moduleView.setupLoad(viewModel: viewModel)
        dataManager.items = viewModel.items
        moduleView.setupDataManager(dataManager: dataManager)
    }
    
    func displayNameInput(viewModel: AlbumsFeedDataFlow.NameInput.ViewModel) {
        
        switch viewModel {
        case .success(let items):
            dataManager.items = items
            moduleView.setupDataManager(dataManager: dataManager)
        case let .failure(title, description):
            let alert = AlertWindowController.alert(title: title,
                                                    message: description,
                                                    cancel: NSLocalizedString("Ok", comment: ""))
            alert.show()
            
            let request = AlbumsFeedDataFlow.UpdateStatus.Request()
            self.interactor?.updateStatus(request: request)
        }
    }
    
    func displayLoadingAlbums(viewModel: AlbumsFeedDataFlow.LoadingAlbums.ViewModel) {
        dataManager.items = viewModel.items
        moduleView.setupDataManager(dataManager: dataManager)
    }
    
    func displayUpdateStatus(viewModel: AlbumsFeedDataFlow.UpdateStatus.ViewModel) {
        dataManager.items = viewModel.items
        moduleView.setupDataManager(dataManager: dataManager)
    }
    
    func displaySelectAlbum(viewModel: AlbumsFeedDataFlow.SelectAlbum.ViewModel) {
        moduleOutput?.albumsFeedModuleDidShowAlbumsDetail(album: viewModel.album)
    }
}
