//
//  AppearanceManager.swift
//  SettingsView
//
//  Created by Виталий Татун on 10.04.23.
//

import Foundation
import UIKit



enum Theme: Int {
    case light
    case dark
    case system
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .light:
            NotificationCenter.default.post(name: Notification.Name("LightIsSelected"), object: nil)
            return .light
        case .dark:
            NotificationCenter.default.post(name: Notification.Name("DarkIsSelected"), object: nil)
            return .dark
        case .system:
            return .unspecified
        }
    }
}
