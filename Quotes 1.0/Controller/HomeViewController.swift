//
//  HomeViewController.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 5.01.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var contentView = QuoteMainView()
    
    var quote = Quote.sampleQuote

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Quotes"
        navigationController?.navigationBar.prefersLargeTitles = true
        var image = UIImage(named: "quoteLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: nil)
        ]
        
        view = contentView
        contentView.quoteCollectionView.dataSource = self
        contentView.quoteCollectionView.delegate = self
    }


}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        quote.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuoteCollectionViewCell.self), for: indexPath) as! QuoteCollectionViewCell
        let quotes = quote[indexPath.item]
        cell.setUpCollectionCell(with: quotes)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
