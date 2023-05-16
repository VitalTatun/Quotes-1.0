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
    private let contentView = UIView()
    
    private let quoteText = UITextView()
    private let quoteAuthor = UITextView()
    private let saveButton = UIBarButtonItem()
    private let authorPlaceholder = UILabel()
    private let textPlaceholder = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupContentView()
        
        setupNavBarItems()
        configureAuthorTextView()
        configureTextView()
        configureNavigationTitle()
        setupPlaceholders()
        registerForKeyboardNotifications()
        
        updateSaveButtonState()
        
        view.backgroundColor = UIColor.itemBackgroundColor
    }
    
    private func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
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
    
    private func setupNavBarItems() {
        saveButton.action = #selector(saveQuote)
        saveButton.style = .plain
        saveButton.title = String(localized: "save_button")
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func configureNavigationTitle() {
        if let quote = quotes {
            quoteText.text = quote.text
            quoteAuthor.text = quote.author
            title = String(localized: "navigation_bar_edit_title")
        } else {
            return title = String(localized: "navigation_bar_new_title")
        }
    }
    
    private func setupPlaceholders() {
        quoteAuthor.delegate = self
        authorPlaceholder.text = String(localized: "author_placeholder")
        authorPlaceholder.font = UIFont(name: "Georgia", size: (quoteAuthor.font?.pointSize)!)
        authorPlaceholder.sizeToFit()
        quoteAuthor.addSubview(authorPlaceholder)
        authorPlaceholder.frame.origin = CGPoint(x: 15, y: (quoteAuthor.font?.pointSize)! / 2)
        authorPlaceholder.textColor = .tertiaryLabel
        authorPlaceholder.isHidden = !quoteAuthor.text.isEmpty
        
        quoteText.delegate = self
        textPlaceholder.text = String(localized: "quote_placeholder")
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
        quoteAuthor.tintColor = UIColor.navigationBarTintColor
        quoteAuthor.becomeFirstResponder()
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
        quoteText.isScrollEnabled = false
        let textInset: CGFloat = 10
        quoteText.backgroundColor = UIColor.itemBackgroundColor
        quoteText.tintColor = UIColor.navigationBarTintColor
        quoteText.textContainerInset = UIEdgeInsets(top: textInset, left: textInset, bottom: textInset, right: textInset)
        contentView.addSubview(quoteText)
        
        quoteText.translatesAutoresizingMaskIntoConstraints = false
        quoteText.topAnchor.constraint(equalTo: quoteAuthor.bottomAnchor).isActive = true
        quoteText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        quoteText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        quoteText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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
    
    private func validate(textView: UITextView) -> Bool {
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

