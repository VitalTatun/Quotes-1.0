//
//  QuoteCollectionViewController+ContextMenu.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 16.01.23.
//

import UIKit

extension QuoteCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash")) { (action) in
                self.deleteQuote(at: indexPath)
            }
            
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { (action) in
                // TODO: Share option as Text (or Image?)
                
            }
            
            let copy = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { (action) in
                //  : Copy quote as text option
                
            }
            let addToFavorites = UIAction(title: "Add to favorites", image: UIImage(systemName: "suit.heart")) { (action) in
                // TODO: Add to favorites option
                
            }
            
            return UIMenu(title: "", image: nil, identifier: nil,
                          options: [], children: [delete, share, copy, addToFavorites])
        }
        return config
    }
}
