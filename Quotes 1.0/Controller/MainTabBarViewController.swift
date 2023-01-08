//
//  MainTabBarViewController.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 5.01.23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let favoriteViewController = UINavigationController(rootViewController: FavoritesViewController())
        
        homeViewController.tabBarItem.image = UIImage(systemName: "text.redaction")
        homeViewController.title = "Quotes"
        favoriteViewController.tabBarItem.image = UIImage(systemName: "text.badge.star")
        favoriteViewController.title = "Favorites"
        tabBar.tintColor = .label
        setViewControllers([homeViewController, favoriteViewController], animated: true)

    }

}
