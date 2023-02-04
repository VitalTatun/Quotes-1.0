//
//  QuoteCollectionViewCell.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 5.01.23.
//

import UIKit

class QuoteCollectionViewCell: UICollectionViewCell {
    
    private let quoteLabel = UILabel()
    private let authorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureText()
        configureAuthor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCollectionCell(with quotes: Quote) {
        quoteLabel.text = quotes.text
        authorLabel.text = quotes.author
    }
    
    private func configureText() {
        if  let customFont = UIFont(name: "Georgia", size: 18) {
            quoteLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        }
        quoteLabel.textAlignment = .left
        quoteLabel.numberOfLines = 0
        quoteLabel.lineBreakMode = .byTruncatingTail
        quoteLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        addSubview(quoteLabel)
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        quoteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        quoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureAuthor() {
        if  let customFont = UIFont(name: "Georgia Bold", size: 22) {
            authorLabel.font = UIFontMetrics(forTextStyle: .title3).scaledFont(for: customFont)
        }
        authorLabel.textAlignment = .left
        authorLabel.numberOfLines = 5
        authorLabel.lineBreakMode = .byWordWrapping
        authorLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 10).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
}
