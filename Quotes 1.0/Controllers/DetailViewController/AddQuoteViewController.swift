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
    
    private var scrollView = UIScrollView()
    let contentView = UIView()
    
    let quoteText = UITextView()
    let quoteAuthor = UITextView()
    let saveButton = UIBarButtonItem()
    let authorPlaceholder = UILabel()
    let textPlaceholder = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupContentView()
        
        setupNavBarItems()
        configureAuthorTextView()
        configureTextView()
        configureNavigationTitle()
        setupAuthorPlaceholder()
        setupTextPlaceholder()
        registerForKeyboardNotifications()
        
        updateSaveButtonState()
        
        view.backgroundColor = UIColor.itemBackgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    fileprivate func setupScrollView() {
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    private func setupContentView() {
        contentView.frame.size = contentSize
        scrollView.addSubview(contentView)
    }
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height-200)
    }
    
    func registerForKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        @objc func keyboardWasShown(_ notificiation: NSNotification) {
            guard let info = notificiation.userInfo,
                let keyboardFrameValue =
                info[UIResponder.keyboardFrameBeginUserInfoKey]
                as? NSValue else { return }
            let keyboardFrame = keyboardFrameValue.cgRectValue
            let keyboardSize = keyboardFrame.size
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0,
            bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
        @objc func keyboardWillBeHidden(_ notification:
           NSNotification) {
            let contentInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    
    fileprivate func setupNavBarItems() {
        saveButton.action = #selector(saveQuote)
        saveButton.style = .plain
        saveButton.title = "Save"
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
    private func configureAuthorTextView() {
        if  let customFont = UIFont(name: "Georgia", size: 20) {
            quoteAuthor.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        }
        let textInset: CGFloat = 10
        quoteAuthor.backgroundColor = UIColor.itemBackgroundColor
        quoteAuthor.textContainerInset = UIEdgeInsets(top: textInset, left: textInset, bottom: textInset, right: textInset)
        
        contentView.addSubview(quoteAuthor)
        
        quoteAuthor.translatesAutoresizingMaskIntoConstraints = false
        quoteAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        quoteAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        quoteAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        quoteAuthor.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func configureTextView() {
        if  let customFont = UIFont(name: "Georgia", size: 18) {
            quoteText.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        }
        let textInset: CGFloat = 10
        quoteText.backgroundColor = UIColor.itemBackgroundColor
        quoteText.tintColor = UIColor.navigationBarTintColor
        quoteText.textContainerInset = UIEdgeInsets(top: textInset, left: textInset, bottom: textInset, right: textInset)
        quoteText.becomeFirstResponder()
        contentView.addSubview(quoteText)
        
        quoteText.translatesAutoresizingMaskIntoConstraints = false
        quoteText.topAnchor.constraint(equalTo: quoteAuthor.bottomAnchor).isActive = true
        quoteText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        quoteText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        quoteText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
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

