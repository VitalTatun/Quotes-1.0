//
//  QuoteCollectionViewController+Actions.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 15.01.23.
//

import UIKit

extension QuoteCollectionViewController: AddQuoteViewControllerDelegate {
    
    // MARK: - Delegate actions
    func didSaveButtonTapped(quote: Quote) {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first?.item {
            quotes[selectedIndexPath] = quote
            collectionView.reloadData()
        } else {
            quotes.insert(quote, at: 0)
            collectionView.reloadData()
        }
        FileManager.saveToFile(quotes: quotes)
    }
    
    // MARK: - VC Actions
    @objc func addQuote(_ sender: UIBarButtonItem) {
        let viewController = AddQuoteViewController()
        viewController.quoteViewControllerDelegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}
