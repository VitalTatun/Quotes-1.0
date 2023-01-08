//
//  QuoteMainView.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 5.01.23.
//

import UIKit

class QuoteMainView: UIView {

    var quoteCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureQuoteCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureQuoteCollectionView()

        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureQuoteCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(QuoteCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: QuoteCollectionViewCell.self))
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        self.quoteCollectionView = collectionView
    }
    
}
