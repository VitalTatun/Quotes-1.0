//
//  DetailTableViewController.swift
//  SettingsView
//
//  Created by Виталий Татун on 29.03.23.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    let mySwich = UISwitch()

    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = String(localized: "settings_screen_title")
        view.backgroundColor = UIColor.collectionBackgroundColor
        
        tableView.register(AppearanceCell.self, forCellReuseIdentifier: String(describing: AppearanceCell.self))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.isScrollEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSwitchState), name: Notification.Name("LightIsSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSwitchState), name: Notification.Name("DarkIsSelected"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSwitchState()

    }
    
    private func isFirstCell(tableView: UITableView,atIndexPath indexPath: IndexPath) -> Bool {
        return indexPath.row == 0 && indexPath.section == 0
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        switch section {
        case .Appearance:
            return SettingsSection.allCases.count
        case .Font:
            return FontOptions.allCases.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell()}
        switch section {
        case .Appearance:
            if isFirstCell(tableView: tableView,atIndexPath: indexPath) {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppearanceCell.self), for: indexPath) as! AppearanceCell
                cell.selectionStyle = .none
                cell.backgroundColor = UIColor.itemBackgroundColor
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
                
                var configuration = cell.defaultContentConfiguration()
                configuration.text = AppearanceOptions.automatic.description
                mySwich.addTarget(self, action: #selector(systemAppearanceSwifthisOn), for: .valueChanged)
                cell.selectionStyle = .none
                cell.accessoryView = mySwich
                cell.backgroundColor = UIColor.itemBackgroundColor
                cell.contentConfiguration = configuration
                return cell
            }
        case .Font:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: String(describing: AppearanceCell.self))
            let fonts = FontOptions(rawValue: indexPath.row)
            var configuration = cell.defaultContentConfiguration()
            configuration.text = fonts?.description
            configuration.secondaryText = "Gergia"
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = UIColor.itemBackgroundColor
            cell.contentConfiguration = configuration
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingsSection(rawValue: section)?.description
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard isFirstCell(tableView: tableView, atIndexPath: indexPath) else {
            return 44
        }
        return 260
    }
    
    @objc func systemAppearanceSwifthisOn() {
        guard let window = view.window else { return }

        NotificationCenter.default.post(name: Notification.Name("isOn"), object: nil)
        if mySwich.isOn {
            updateSwitchState()
            UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.view.window?.overrideUserInterfaceStyle = SettingsUserDefaults.shared.theme.getUserInterfaceStyle()
                }, completion: nil)
        } else {
            SettingsUserDefaults.shared.theme = Theme.light
            UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.view.window?.overrideUserInterfaceStyle = SettingsUserDefaults.shared.theme.getUserInterfaceStyle()
                }, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("AutomaticModeIsOff"), object: nil)
        }
    }

    @objc func updateSwitchState() {
        if SettingsUserDefaults.shared.theme == .system {
            mySwich.setOn(true, animated: true)
        } else {
            mySwich.setOn(false, animated: true)
        }
    }
}
