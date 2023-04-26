//
//  HomeViewController.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 5.01.23.
//

import UIKit

class QuoteCollectionViewController: UICollectionViewController {
    
    let searchController = UISearchController()
    
    var quotes: [Quote] = []
    var filteredQuotes: [Quote] = []
    var isFiltering: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return searchController.isActive && !text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Quotes"
        if let savedQuotes = FileManager.loadFromFile() {
            quotes = savedQuotes
        } else {
            quotes = Quote.sampleQuote
        }
        setupNavBarItems()
        setupNavigationBar()
        setupSearchBar()
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(QuoteCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: QuoteCollectionViewCell.self))
        collectionView.backgroundColor = UIColor.collectionBackgroundColor
    }
    
    func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = String(localized: "searchBar_placeholder")
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
    }
    
    fileprivate func setupNavigationBar() {
        let largeTextFont = UIFont(name: "Georgia Bold", size: 30)
        let standartTextFont = UIFont(name: "Georgia Bold", size: 20)
        if let appearance = navigationController?.navigationBar.standardAppearance {
            guard let standartTextFont = standartTextFont, let largeTextFont = largeTextFont else {return}
            appearance.titleTextAttributes = [.foregroundColor: UIColor.navigationBarTitles, .font: standartTextFont]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.navigationBarTitles, .font: largeTextFont]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    fileprivate func setupNavBarItems() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addQuote(_:)))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: #selector(goToSettings))
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 30, weight: .light)
        ]
        navigationItem.backButtonTitle = String(localized: "back_button")
        navigationController?.navigationBar.tintColor = UIColor.navigationBarTintColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = settingsButton
    }
    
    func deleteQuote(at indexPath: IndexPath) {
        if isFiltering {
            let result = filteredQuotes[indexPath.item]
            filteredQuotes.remove(at: indexPath.item)
            quotes.removeAll { item in
                item.text == result.text
            }
        } else {
            quotes.remove(at: indexPath.item)
        }
        collectionView.deleteItems(at: [indexPath])
        FileManager.saveToFile(quotes: quotes)
    }
    
// MARK: - CollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let emptyViewMessage = String(localized: "no_quote_added_message")
        if quotes.count == 0 {
            collectionView.setEmptyMessage(emptyViewMessage)
        } else {
            collectionView.restore()
        }
        if isFiltering {
            return filteredQuotes.count
        } else {
            return quotes.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuoteCollectionViewCell.self), for: indexPath) as! QuoteCollectionViewCell
        let item: Quote
        if isFiltering {
            item = filteredQuotes[indexPath.item]
        } else {
            item = quotes[indexPath.item]
        }
        cell.backgroundColor = UIColor.itemBackgroundColor
        cell.setUpCollectionCell(with: item)
        return cell
    }
    
// MARK: - CollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quoteToEdit = quotes[indexPath.item]
        let addEditViewController = AddQuoteViewController()
        if isFiltering {
            let filteredQuote = filteredQuotes[indexPath.item]
            addEditViewController.quotes = filteredQuote
        } else {
            addEditViewController.quotes = quoteToEdit
        }
        addEditViewController.quoteViewControllerDelegate = self
        navigationController?.pushViewController(addEditViewController, animated: true)
    }
}

// MARK: - Flow Layout Delegate

extension QuoteCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 1.6)
    }
}

// MARK: SearchBar

extension QuoteCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text,
           searchString.isEmpty == false {
            filteredQuotes = quotes.filter { (quote) -> Bool in
                quote.text?.localizedStandardContains(searchString) ?? false || quote.author?.localizedCaseInsensitiveContains(searchString) ?? false }
        } else {
            filteredQuotes = quotes
        }
        collectionView.reloadData()
    }
}

