//
//  AlbumsDetailViewController.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AlbumsDetailControllerLogic: class {
    func displayLoad(viewModel: AlbumsDetailDataFlow.Load.ViewModel)
}

protocol AlbumsDetailModuleOutput: class {

}

protocol AlbumsDetailModuleInput: class {

}

final class AlbumsDetailViewController: UIViewController,
    AlbumsDetailControllerLogic, AlbumsDetailModuleInput, AlbumsDetailViewDelegate {

    // MARK: - Properties

    var interactor: AlbumsDetailBusinessLogic?

    weak var moduleOutput: AlbumsDetailModuleOutput?

    var moduleView: AlbumsDetailView!
    
    private let dataManager = AlbumsDetailDataManager()

    // MARK: - View life cycle

    override func loadView() {
        moduleView = AlbumsDetailView(frame: UIScreen.main.bounds)
        moduleView.delegate = self
        view = moduleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Альбом", comment: "")
        navigationController?.navigationBar.tintColor = .white
        
        startLoading()
    }

    // MARK: - AlbumsDetailControllerLogic

    private func startLoading() {
        IndicatorAlertController.show()
        let request = AlbumsDetailDataFlow.Load.Request()
        interactor?.load(request: request)
    }

    func displayLoad(viewModel: AlbumsDetailDataFlow.Load.ViewModel) {
        IndicatorAlertController.hide()
        switch viewModel {
        case .success(let items):
            dataManager.items = items
            moduleView.setupDataManager(dataManager: dataManager)
        case let .failure(title, description):
            let alert = AlertWindowController.alert(title: title,
                                                    message: description,
                                                    cancel: NSLocalizedString("Ok", comment: ""))
            alert.show()
        }
        
        moduleView.setupLoad(viewModel: viewModel)
    }
}
