//
//  SectionSettings.swift
//  SettingsView
//
//  Created by Виталий Татун on 29.03.23.
//

enum SettingsSection: Int, CaseIterable {
    case Appearance
    case Font
    
    var description: String {
        switch self {
        case .Appearance:
            return String(localized: "settings_section_appearance")
        case .Font:
            return String(localized: "settings_section_fonts")
        }
    }
}

enum AppearanceOptions: Int, CaseIterable {
    case light
    case dark
    case automatic
    
    var description: String {
        switch self {
        case .light:
            return String(localized: "settings_section_appearance_light")
        case .dark:
            return String(localized: "settings_section_appearance_dark")
        case .automatic:
            return String(localized: "settings_section_appearance_automatic")
        }
    }
}

enum FontOptions: Int, CaseIterable {
    case fonts
    
    var description: String {
        switch self {
        case .fonts:
            return String(localized: "settings_section_font")
        }
    }
}
