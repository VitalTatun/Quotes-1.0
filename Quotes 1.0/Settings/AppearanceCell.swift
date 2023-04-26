//
//  AppearanceCell.swift
//  SettingsView
//
//  Created by Виталий Татун on 28.03.23.
//

import UIKit

class AppearanceCell: UITableViewCell {
    
    private let lightModeImage = UIImageView()
    private let lightModeLabel = UILabel()
    private let lightModeCheckmark = UIButton()
    
    private let darkModeImage = UIImageView()
    private let darkModeLabel = UILabel()
    private let darkModeCheckmark = UIButton()
    
    private let VStackLightView = UIStackView()
    private let VStackDarkView = UIStackView()
    
    private let HStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHStack()
        
        setupVStackLightMode()
        setupVStackDarkMode()
        
        setupLightModeImage()
        setupLightLabel()
        setupLightCheckmark()
        
        setupDarkModeImage()
        setupDarkLabel()
        setupDarkCheckmark()
        
        updateStateButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifySystemSwitchIsActive), name: Notification.Name("isOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(defaultMode), name: Notification.Name("AutomaticModeIsOff"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHStack() {
        HStackView.axis = .horizontal
        HStackView.distribution = .fillEqually
        HStackView.alignment = .center
        HStackView.backgroundColor = .clear
        
        HStackView.addArrangedSubview(VStackLightView)
        HStackView.addArrangedSubview(VStackDarkView)
        
        HStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(HStackView)
        
        HStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        HStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        HStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        HStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
    }
    
    func setupVStackDarkMode() {
        VStackDarkView.axis = .vertical
        VStackDarkView.distribution = .equalSpacing
        VStackDarkView.alignment = .center
        VStackDarkView.backgroundColor = .clear
        
        VStackDarkView.addArrangedSubview(darkModeImage)
        VStackDarkView.addArrangedSubview(darkModeLabel)
        VStackDarkView.addArrangedSubview(darkModeCheckmark)
        VStackDarkView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupVStackLightMode() {
        VStackLightView.axis = .vertical
        VStackLightView.distribution = .equalSpacing
        VStackLightView.alignment = .center
        VStackLightView.backgroundColor = .clear
        
        VStackLightView.addArrangedSubview(lightModeImage)
        VStackLightView.addArrangedSubview(lightModeLabel)
        VStackLightView.addArrangedSubview(lightModeCheckmark)
        VStackLightView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLightModeImage() {
        lightModeImage.backgroundColor = .red
        lightModeImage.image = UIImage(named: "lightMode")
        lightModeImage.contentMode = .scaleAspectFit
        lightModeImage.layer.cornerRadius = 10
        lightModeImage.layer.borderWidth = 1
        lightModeImage.layer.borderColor = UIColor.black.cgColor
        lightModeImage.clipsToBounds = true
        lightModeImage.translatesAutoresizingMaskIntoConstraints = false
        lightModeImage.heightAnchor.constraint(equalToConstant: 139).isActive = true
        lightModeImage.widthAnchor.constraint(equalToConstant: 64).isActive = true
        lightModeImage.topAnchor.constraint(equalTo: VStackLightView.topAnchor).isActive = true
    }
    
    func setupDarkModeImage() {
        darkModeImage.backgroundColor = .red
        darkModeImage.image = UIImage(named: "darkMode")
        darkModeImage.contentMode = .scaleAspectFit
        darkModeImage.layer.cornerRadius = 10
        darkModeImage.layer.borderWidth = 1
        darkModeImage.layer.borderColor = UIColor.black.cgColor
        darkModeImage.clipsToBounds = true
        darkModeImage.translatesAutoresizingMaskIntoConstraints = false
        darkModeImage.heightAnchor.constraint(equalToConstant: 139).isActive = true
        darkModeImage.widthAnchor.constraint(equalToConstant: 64).isActive = true
        darkModeImage.topAnchor.constraint(equalTo: VStackDarkView.topAnchor).isActive = true
    }
    
    func setupLightLabel() {
        lightModeLabel.text = AppearanceOptions.light.description
        lightModeLabel.textColor = .label
//        lightModeLabel.topAnchor.constraint(equalTo: lightModeImage.bottomAnchor, constant: 10).isActive = true
        lightModeLabel.topAnchor.constraint(greaterThanOrEqualTo: lightModeImage.bottomAnchor, constant: 10).isActive = true
    }
    func setupDarkLabel() {
        darkModeLabel.text = AppearanceOptions.dark.description
        darkModeLabel.textColor = .label
//        darkModeLabel.topAnchor.constraint(equalTo: darkModeImage.bottomAnchor, constant: 10).isActive = true
        darkModeLabel.topAnchor.constraint(greaterThanOrEqualTo: darkModeImage.bottomAnchor, constant: 10).isActive = true

    }
    
    func setupLightCheckmark() {
        let size: CGFloat = 30
        let checkmark = UIImage(systemName: "circle")
        let selectedCheckmark = UIImage(systemName: "circle.inset.filled")
        
        lightModeCheckmark.setBackgroundImage(checkmark, for: .normal)
        lightModeCheckmark.setBackgroundImage(selectedCheckmark, for: .selected)
        lightModeCheckmark.tintColor = UIColor.navigationBarTintColor
        
        lightModeCheckmark.addTarget(self, action: #selector(didTapLightCheckbox), for: .touchUpInside)
        lightModeCheckmark.translatesAutoresizingMaskIntoConstraints = false
        
        lightModeCheckmark.topAnchor.constraint(equalTo: lightModeLabel.bottomAnchor, constant: 10).isActive = true
        lightModeCheckmark.heightAnchor.constraint(equalToConstant: size).isActive = true
        lightModeCheckmark.widthAnchor.constraint(equalToConstant: size).isActive = true
        
        
    }
    
    func setupDarkCheckmark() {
        let size: CGFloat = 30
        let checkmark = UIImage(systemName: "circle")
        let selectedCheckmark = UIImage(systemName: "circle.inset.filled")
        
        darkModeCheckmark.setBackgroundImage(checkmark, for: .normal)
        darkModeCheckmark.setBackgroundImage(selectedCheckmark, for: .selected)
        darkModeCheckmark.tintColor = UIColor.navigationBarTintColor

        darkModeCheckmark.translatesAutoresizingMaskIntoConstraints = false
        darkModeCheckmark.addTarget(self, action: #selector(didTapDarkCheckbox), for: .touchUpInside)
        
        darkModeCheckmark.topAnchor.constraint(equalTo: darkModeLabel.bottomAnchor, constant: 10).isActive = true
        darkModeCheckmark.heightAnchor.constraint(equalToConstant: size).isActive = true
        darkModeCheckmark.widthAnchor.constraint(equalToConstant: size).isActive = true
        
    }
    
    @objc func didTapDarkCheckbox(sender: UIButton) {
        updateCheckmark(sender)
        updateTheme()
    }
    @objc func didTapLightCheckbox(sender: UIButton) {
        updateCheckmark(sender)
        updateTheme()
        
    }
    
    fileprivate func updateCheckmark(_ selectedButton: UIButton) {
        let buttons:[UIControl] = [lightModeCheckmark,darkModeCheckmark]
        buttons.forEach { button in
            if button == selectedButton {
                selectedButton.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
    
    @objc func notifySystemSwitchIsActive() {
        darkModeCheckmark.isSelected = false
        lightModeCheckmark.isSelected = false
        SettingsUserDefaults.shared.theme = Theme.system
        window?.overrideUserInterfaceStyle = SettingsUserDefaults.shared.theme.getUserInterfaceStyle()
    }
    @objc func defaultMode() {
        darkModeCheckmark.isSelected = false
        lightModeCheckmark.isSelected = true
        SettingsUserDefaults.shared.theme = Theme.light
        window?.overrideUserInterfaceStyle = SettingsUserDefaults.shared.theme.getUserInterfaceStyle()
    }
    
    private func updateTheme() {
        guard let window = window else { return }

        if lightModeCheckmark.isSelected {
            SettingsUserDefaults.shared.theme = Theme.light
            UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.window?.overrideUserInterfaceStyle = SettingsUserDefaults.shared.theme.getUserInterfaceStyle()
                }, completion: nil)
        } else if darkModeCheckmark.isSelected {
            SettingsUserDefaults.shared.theme = Theme.dark
            UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.window?.overrideUserInterfaceStyle = SettingsUserDefaults.shared.theme.getUserInterfaceStyle()
                }, completion: nil)
        } else {
            SettingsUserDefaults.shared.theme = Theme.system
            window.overrideUserInterfaceStyle = SettingsUserDefaults.shared.theme.getUserInterfaceStyle()

           
        }
    }
    private func updateStateButton() {
        switch SettingsUserDefaults.shared.theme {
        case .light:
            lightModeCheckmark.isSelected = true
        case .dark:
            darkModeCheckmark.isSelected = true
        case .system:
            darkModeCheckmark.isSelected = false
            lightModeCheckmark.isSelected = false
        }
    }
    
}

