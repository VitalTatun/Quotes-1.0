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
    var authorPlaceholder = UILabel()
    var textPlaceholder = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarItems()
        configureTextView()
        configureAuthorTextView()
        configureNavigationTitle()
        setupAuthorPlaceholder()
        setupTextPlaceholder()
        updateSaveButtonState()
        
        view.backgroundColor = UIColor(named: "ItemBackgroundColor")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    fileprivate func setupNavBarItems() {
        saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveQuote))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    fileprivate func configureNavigationTitle() {
        if let quote = quotes {
            quoteText.text = quote.text
            quoteAuthor.text = quote.author
            title = "Edit quote"
        } else {
            return title = "Add new quote"
        }
    }
    
    fileprivate func setupAuthorPlaceholder() {
        quoteAuthor.delegate = self
        authorPlaceholder.text = "Author"
        authorPlaceholder.font = UIFont(name: "Georgia", size: (quoteAuthor.font?.pointSize)!)
        authorPlaceholder.sizeToFit()
        quoteAuthor.addSubview(authorPlaceholder)
        authorPlaceholder.frame.origin = CGPoint(x: 15, y: (quoteAuthor.font?.pointSize)! / 2)
        authorPlaceholder.textColor = .tertiaryLabel
        authorPlaceholder.isHidden = !quoteAuthor.text.isEmpty
    }
    
    fileprivate func setupTextPlaceholder() {
        quoteText.delegate = self
        textPlaceholder.text = "Text"
        textPlaceholder.font = UIFont(name: "Georgia", size: (quoteText.font?.pointSize)!)
        textPlaceholder.sizeToFit()
        quoteText.addSubview(textPlaceholder)
        textPlaceholder.frame.origin = CGPoint(x: 15, y: (quoteText.font?.pointSize)! / 2)
        textPlaceholder.textColor = .tertiaryLabel
        textPlaceholder.isHidden = !quoteText.text.isEmpty
    }
    
    
    private func configureTextView() {
        if  let customFont = UIFont(name: "Georgia", size: 18) {
            quoteText.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        }
        let textInset: CGFloat = 10
        quoteText.backgroundColor = UIColor(named: "ItemBackgroundColor")
        quoteText.textContainerInset = UIEdgeInsets(top: textInset, left: textInset, bottom: textInset, right: textInset)
        quoteText.becomeFirstResponder()
        view.addSubview(quoteText)
        
        quoteText.translatesAutoresizingMaskIntoConstraints = false
        quoteText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        quoteText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        quoteText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    }
    
    private func configureAuthorTextView() {
        if  let customFont = UIFont(name: "Georgia", size: 20) {
            quoteAuthor.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        }
        let textInset: CGFloat = 10
        quoteAuthor.backgroundColor = UIColor(named: "ItemBackgroundColor")
        quoteAuthor.textContainerInset = UIEdgeInsets(top: textInset, left: textInset, bottom: textInset, right: textInset)
        
        view.addSubview(quoteAuthor)
        
        quoteAuthor.translatesAutoresizingMaskIntoConstraints = false
        quoteAuthor.topAnchor.constraint(equalTo: quoteText.bottomAnchor).isActive = true
        quoteAuthor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        quoteAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        quoteAuthor.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        quoteAuthor.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func saveQuote() {
        guard let text = quoteText.text else {return}
        let author = quoteAuthor.text ?? ""
        let defaultQuote = Quote(text: text, author: author)
        if validate(textView: quoteText) {
            // In case textView is not empty
            quotes = Quote(text: text, author: author)
            quoteViewControllerDelegate?.didSaveButtonTapped(quote: defaultQuote)
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

extension AddQuoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        authorPlaceholder.isHidden = !quoteAuthor.text.isEmpty
        textPlaceholder.isHidden = !quoteText.text.isEmpty
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let text = quoteText.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

