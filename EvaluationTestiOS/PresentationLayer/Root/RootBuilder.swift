//
//  RootBuilder.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import UIKit

protocol RootBuildable {
    func build(withModuleOutput output: RootModuleOutput?) -> UINavigationController & RootModuleInput
}

private struct Builders: RootBuilders {
    var albumsFeed: AlbumsFeedBuildable
    var albumsDetail: AlbumsDetailBuildable
}

final class RootBuilder: RootBuildable {
    
    // MARK: - Properties
    
    let dependency: RootDependency
    
    // MARK: - Init
    
    init(dependency: RootDependency) {
        self.dependency = dependency
    }
    
    // MARK: - RootBuildable
    
    func build(withModuleOutput output: RootModuleOutput?) -> UINavigationController & RootModuleInput {
        let builders = Builders(albumsFeed: AlbumsFeedBuilder(albumService: dependency.albumService),
                                albumsDetail: AlbumsDetailBuilder(albumService: dependency.albumService))
        
        let viewController = RootViewController(appDependency: dependency, builders: builders)
        return viewController
    }
}
