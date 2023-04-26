//
//  UserDefaults.swift
//  SettingsView
//
//  Created by Виталий Татун on 10.04.23.
//

import Foundation

struct SettingsUserDefaults {
    static var shared = SettingsUserDefaults()
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "selectedTheme")) ?? .light
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
        }
    }
}
