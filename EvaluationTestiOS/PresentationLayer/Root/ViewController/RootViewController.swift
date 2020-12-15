//
//  RootViewController.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import UIKit

protocol RootModuleOutput: class {
    
}

protocol RootModuleInput: class {
    
}

protocol RootBuilders {
    var albumsFeed: AlbumsFeedBuildable { get }
    var albumsDetail: AlbumsDetailBuildable { get }
}

final class RootViewController: UINavigationController, RootModuleInput {
    
    // MARK: - Properties

    weak var moduleOutput: RootModuleOutput?
    
    private let appDependency: RootDependency
    
    private let builders: RootBuilders
    
    // MARK: - Init
    
    init(appDependency: RootDependency, builders: RootBuilders) {
        self.appDependency = appDependency
        self.builders = builders

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLoading()
    }
    
    // MARK: - RootControllerLogic
    
    private func startLoading() {
        
        let viewController = builders.albumsFeed.build(withModuleOutput: self)
        viewControllers = [viewController]
    }
}

extension RootViewController: AlbumsFeedModuleOutput {
    
    func albumsFeedModuleDidShowAlbumsDetail(album: AlbumModel) {
        let viewController = builders.albumsDetail.build(withModuleOutput: self, album: album)
        pushViewController(viewController, animated: true)
    }
}

extension RootViewController: AlbumsDetailModuleOutput {
    
    func albumsDetailModuleDidBack() {
        navigationController?.popViewController(animated: true)
        //navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
