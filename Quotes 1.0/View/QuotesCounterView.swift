//
//  QuotesCounterView.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 16.05.23.
//

import UIKit

class QuotesCounterView: UIView {
    
    private let counterBackground = UIView()
    private let counterLbl = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCounterBackground()
        setupCounterLbl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCounterBackground() {
        counterBackground.backgroundColor = UIColor.navigationBarTitles
        counterBackground.layer.cornerRadius = 20

        counterBackground.layer.shadowOffset = CGSize(width: 1, height: 5)
        addSubview(counterBackground)
        counterBackground.translatesAutoresizingMaskIntoConstraints = false
        counterBackground.heightAnchor.constraint(equalToConstant: 40).isActive = true
        counterBackground.widthAnchor.constraint(equalToConstant: 40).isActive = true
        counterBackground.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupCounterLbl() {
        counterLbl.textColor = .white
        counterLbl.numberOfLines = 1
        counterBackground.addSubview(counterLbl)
        counterLbl.translatesAutoresizingMaskIntoConstraints = false
        counterLbl.centerXAnchor.constraint(equalTo: counterBackground.centerXAnchor).isActive = true
        counterLbl.centerYAnchor.constraint(equalTo: counterBackground.centerYAnchor).isActive = true
    }
    
}
extension QuotesCounterView {
    
    func configureCounterView(filteredQuotes: [Quote], couterView: UIView) {
        let moveFromTopAnimation = CGAffineTransform.init(translationX: 0, y: 17)
        guard filteredQuotes.count >= 0 else { return }
        counterLbl.text = "\(filteredQuotes.count)"
        couterView.isHidden = false
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.3,
            animations: {
                couterView.transform = moveFromTopAnimation
                couterView.alpha = 1
            })
        
    }
    
    func hideCounter(counterView: UIView) {
        UIView.animate(withDuration: 0.2, delay: 0.2) {
            counterView.transform = .identity
            counterView.alpha = 0
        }
    }
}
