//
//  DetailViewController.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 16.01.23.
//

import UIKit

protocol AddQuoteViewControllerDelegate: AnyObject {
    func didSaveButtonTapped(quote: Quote)
}

class AddQuoteViewController: UIViewController {
    
    var quotes: Quote?
    
    weak var quoteViewControllerDelegate: AddQuoteViewControllerDelegate?
    
    let quoteText = UITextView()
    let quoteAuthor = UITextView()
    var saveButton = UIBarButtonItem()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavBarItems()
        configureTextView()
        configureAuthorTextView()
        configureNavigationTitle()
        
        
    }
    
    fileprivate func setupNavBarItems() {
        saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveQuote))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    fileprivate func configureNavigationTitle() {
        guard let quote = quotes else {
            return title = "Add emoji"
        }
            quoteText.text = quote.text
            quoteAuthor.text = quote.author
            title = "Edit Emoji"
    }
    
    private func configureTextView() {
        quoteText.textAlignment = .left
        quoteText.font = .preferredFont(forTextStyle: .body)
        quoteText.layer.cornerRadius = 10
        quoteText.backgroundColor = .white
        
        view.addSubview(quoteText)
        
        quoteText.translatesAutoresizingMaskIntoConstraints = false
        quoteText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        quoteText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        quoteText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    }
    
    private func configureAuthorTextView() {
        quoteAuthor.textAlignment = .left
        quoteAuthor.font = .preferredFont(forTextStyle: .body)
        quoteAuthor.backgroundColor = .clear
        view.addSubview(quoteAuthor)
        
        quoteAuthor.translatesAutoresizingMaskIntoConstraints = false
        quoteAuthor.topAnchor.constraint(equalTo: quoteText.bottomAnchor, constant: 20).isActive = true
        quoteAuthor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        quoteAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        quoteAuthor.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        quoteAuthor.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    @objc func saveQuote() {
        let text = quoteText.text
        let author = quoteAuthor.text ?? ""
        
        if validate(textView: quoteText) {
            // In case textView is not empty
            quotes = Quote(text: text!, author: author, isFavorite: false)
            quoteViewControllerDelegate?.didSaveButtonTapped(quote: quotes!)
            navigationController?.popViewController(animated: true)
        } else {
            // in case textView is empty
            print("No data")
        }
    }
    
    func validate(textView: UITextView) -> Bool {
        // this will be reached if the text is nil
        // or if the text only contains white spaces
        // or no text at all
        guard let text = textView.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }
}
