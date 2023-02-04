//
//  CollectionView + EmptyView.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 1.02.23.
//

import UIKit

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .label
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.font = UIFont(name: "Georgia", size: 17)
        messageLabel.sizeToFit()
        backgroundView = messageLabel
    }
    
    func restore() {
        backgroundView = nil
    }
}

