//
//  SearchCoordinator.swift
//  Emby Player
//
//  Created by Mats Mollestad on 13/09/2018.
//  Copyright © 2018 Mats Mollestad. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinating, SearchViewControllerDelegate {

    let tabBarController: UITabBarController

    let searchController = SearchViewController()
//    lazy var contentController = ContentStateViewController(contentController: self.searchController, fetchMode: .onAppeare, backgroundColor: .black)
    lazy var navigationController = UINavigationController(rootViewController: self.searchController)

    var coordinator: Coordinating?

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        searchController.delegate = self
        var viewControllers = tabBarController.viewControllers ?? []
        viewControllers.append(navigationController)
        tabBarController.setViewControllers(viewControllers, animated: true)
    }

    func itemWasTapped(_ item: BaseItem) {

        if item.type == "Series" {
            coordinator = TvShowCoordinator(presenter: navigationController, item: item)
        } else if item.isFolder == true {
            let mediaFoler = MediaFolder(item: item)
            coordinator = MediaLibraryCoordinator(presenter: navigationController, mediaFolder: mediaFoler)
        } else {
            coordinator = EmbyItemCoordiantor(presenter: navigationController, itemId: item.id)
        }

        coordinator?.start()
    }
}
