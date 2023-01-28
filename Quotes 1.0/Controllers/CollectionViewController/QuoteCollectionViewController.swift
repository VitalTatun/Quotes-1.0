//
//  HomeViewController.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 5.01.23.
//

import UIKit

class QuoteCollectionViewController: UICollectionViewController {
    
    var quotes: [Quote] = []
    let appTitle = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Quotes"
        
        
        setupNavBarItems()
        if quotes.isEmpty {
            quotes = Quote.sampleQuote
        }
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(QuoteCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: QuoteCollectionViewCell.self))
        collectionView.backgroundColor = .systemGray6
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupNavigationBar()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    fileprivate func setupNavigationBar() {
        let largeTextFont = UIFont(name: "Georgia Bold", size: 30)
        let standartTextFont = UIFont(name: "Georgia Bold", size: 20)
        if let appearance = navigationController?.navigationBar.standardAppearance {
            guard let standartTextFont = standartTextFont, let largeTextFont = largeTextFont else {return}
            appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "Navigation Bar Titles")!, .font: standartTextFont]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Navigation Bar Titles")!, .font: largeTextFont]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    fileprivate func setupNavBarItems() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEditQuote(_:)))
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        //        let quoteNameButton = UIBarButtonItem(title: "QUOTES", style: .plain, target: .none, action: nil)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 30, weight: .light)
        ]
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.tintColor = UIColor(named: "Navigation Bar Titles")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationItem.rightBarButtonItems = [addButton, searchButton]
        //        navigationItem.leftBarButtonItem = quoteNameButton
        //        quoteNameButton.setTitleTextAttributes(attributes, for:.normal)
    }
    
    
    func deleteQuote(at indexPath: IndexPath) {
        quotes.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
    }
    
    // MARK: - CollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        quotes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let colors = UIColor.palette()
        //        let colorIndex = indexPath.item % colors.count
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuoteCollectionViewCell.self), for: indexPath) as! QuoteCollectionViewCell
        let quotes = quotes[indexPath.item]
        cell.backgroundColor = .systemGray5
        cell.layer.cornerRadius = 10
        cell.setUpCollectionCell(with: quotes)
        return cell
    }
    
    
    // MARK: - CollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quoteToEdit = quotes[indexPath.item]
        let addEditViewController = AddQuoteViewController()
        addEditViewController.quotes = quoteToEdit
        navigationController?.pushViewController(addEditViewController, animated: true)
    }
    
    
}

// MARK:  - Flow Layout Delegate
extension QuoteCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 1.6)
    }
    
}


