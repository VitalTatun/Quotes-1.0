//
//  MainTabBarViewController.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 5.01.23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private enum TabBarItem {
        case Home
        case Favorites
        
        var title: String {
            switch self {
            case .Home:
                return "Quotes"
            case .Favorites:
                return "Favorites"
            }
        }
        var iconName: String? {
            switch self {
            case .Home: return "text.redaction"
            case .Favorites: return "text.badge.star"
                
            }
        }
        var icon: UIImage? {
            guard let iconName = iconName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle:.headline)
            return UIImage(systemName: iconName, withConfiguration: configuration )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        let mainPageViewController = QuoteCollectionViewController(collectionViewLayout: layout)
        let favoritesViewController = FavoritesQuotesCollectionViewController()
        
        viewControllers = [
            generateTabBarController(rootViewController: mainPageViewController, image: TabBarItem.Home.icon, title: TabBarItem.Home.title),
            generateTabBarController(rootViewController: favoritesViewController, image: TabBarItem.Favorites.icon, title: TabBarItem.Favorites.title)
        ]
        tabBar.tintColor = UIColor(named: "Navigation Bar Titles")
    }
    
    private func generateTabBarController(rootViewController: UIViewController, image: UIImage?, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        return navigationVC
    }
    
}
