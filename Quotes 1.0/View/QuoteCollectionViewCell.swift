//
//  QuoteCollectionViewCell.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 5.01.23.
//

import UIKit

class QuoteCollectionViewCell: UICollectionViewCell {
    
    private let quoteText = UILabel()
    private let quoteAuthor = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureText()
        configureAuthor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCollectionCell(with quotes: Quote) {
        quoteText.text = quotes.textQuote
        quoteAuthor.text = quotes.author
    }
    
    private func configureText() {
        quoteText.textColor = .black
        quoteText.textAlignment = .left
        quoteText.numberOfLines = 0
        addSubview(quoteText)
        quoteText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quoteText.centerYAnchor.constraint(equalTo: centerYAnchor),
            quoteText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            quoteText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    private func configureAuthor() {
        quoteAuthor.textColor = .darkGray
        quoteAuthor.font = UIFont.preferredFont(forTextStyle: .title2)
        quoteAuthor.textColor = .black
        addSubview(quoteAuthor)
        quoteAuthor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quoteAuthor.topAnchor.constraint(equalTo: quoteText.bottomAnchor, constant: 50),
            quoteAuthor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            quoteAuthor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            quoteAuthor.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
