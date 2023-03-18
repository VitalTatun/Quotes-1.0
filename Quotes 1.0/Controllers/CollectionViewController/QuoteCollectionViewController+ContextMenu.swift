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
            let delete = UIAction(
                title: String(localized: "context_menu_delete_action"),
                image: UIImage(systemName: "trash")?.withTintColor(.navigationBarTintColor, renderingMode: .alwaysOriginal)) { (action) in
                self.deleteQuote(at: indexPath)
            }
            
            let share = UIAction(
                title: String(localized: "context_menu_share_action"),
                image: UIImage(systemName: "square.and.arrow.up")) {(action) in
                let activityController: UIActivityViewController
                guard let text = self.quotes[indexPath.item].text,
                      let author = self.quotes[indexPath.item].author else {return}
                let defautQuote = text + author
                    activityController = UIActivityViewController(activityItems: [defautQuote], applicationActivities: nil)
                print(defautQuote)
                    self.present(activityController, animated: true, completion: nil)
            }
            
            let copy = UIAction(
                title: String(localized: "context_menu_copy_action"),
                image: UIImage(systemName: "doc.on.doc")) { (action) in
                let pasteboard = UIPasteboard.general
                guard let text = self.quotes[indexPath.item].text else { return }
                guard let author = self.quotes[indexPath.item].author else {
                    let defaultQuote = text
                    pasteboard.string = defaultQuote
                    return
                }
                let defaultQuote = text + author
                pasteboard.string = defaultQuote
            }
            return UIMenu(title: "", image: nil, identifier: nil,
                          options: [], children: [delete, share, copy])
        }
        return config
    }
}
