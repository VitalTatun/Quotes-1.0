//
//  FavoritesQuotesCollectionViewController.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 15.01.23.
//

import UIKit

class FavoritesQuotesCollectionViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favorites quotes"
        
        view.backgroundColor = .magenta
    }
    
}


