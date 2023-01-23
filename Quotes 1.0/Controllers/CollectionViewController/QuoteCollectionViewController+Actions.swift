//
//  QuoteCollectionViewController+Actions.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 15.01.23.
//

import UIKit

extension QuoteCollectionViewController: AddQuoteViewControllerDelegate {
    
    func didSaveButtonTapped(quote: Quote) {
        quotes.insert(quote, at: 0)
        collectionView.reloadData()
    }
    
    // MARK: - VC Actions
    
    @objc func addEditQuote(_ sender: UIBarButtonItem) {
        let viewController = AddQuoteViewController()
        viewController.quoteViewControllerDelegate = self
        navigationController?.pushViewController(viewController, animated: true)

    }
    
    
}
