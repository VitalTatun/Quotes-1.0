//
//  HomeViewController.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 5.01.23.
//

import UIKit

class QuoteCollectionViewController: UICollectionViewController {
    
    var quotes: [Quote] = []
    
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

        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(QuoteCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: QuoteCollectionViewCell.self))
        collectionView.backgroundColor = UIColor.collectionBackgroundColor
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
            appearance.titleTextAttributes = [.foregroundColor: UIColor.navigationBarTitles, .font: standartTextFont]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.navigationBarTitles, .font: largeTextFont]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    fileprivate func setupNavBarItems() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addQuote(_:)))
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 30, weight: .light)
        ]
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.tintColor = UIColor.navigationBarTintColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationItem.rightBarButtonItems = [addButton, searchButton]
    }
    
    
    func deleteQuote(at indexPath: IndexPath) {
        quotes.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
        FileManager.saveToFile(quotes: quotes)
    }
    
    // MARK: - CollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let emptyViewMessage = "No quotes found"
        if quotes.count == 0 {
                collectionView.setEmptyMessage(emptyViewMessage)
            } else {
                collectionView.restore()
            }
            return quotes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuoteCollectionViewCell.self), for: indexPath) as! QuoteCollectionViewCell
        let item = quotes[indexPath.item]
        cell.backgroundColor = UIColor.itemBackgroundColor
        cell.setUpCollectionCell(with: item)
        return cell
    }
    
    // MARK: - CollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quoteToEdit = quotes[indexPath.item]
        let addEditViewController = AddQuoteViewController()
        addEditViewController.quotes = quoteToEdit
        addEditViewController.quoteViewControllerDelegate = self
        navigationController?.pushViewController(addEditViewController, animated: true)
    }
    
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        <#code#>
//    }
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


