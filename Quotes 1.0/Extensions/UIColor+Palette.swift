//
//  UIColor+Palette.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 7.01.23.
//

import UIKit

extension UIColor {
    
    static var collectionBackgroundColor: UIColor {
        UIColor(named: "CollectionBackgroundColor") ?? .systemGray5
    }
    static var navigationBarTitles: UIColor {
        UIColor(named: "NavigationBarTitles") ?? .systemOrange
    }
    static var itemBackgroundColor: UIColor {
        UIColor(named: "ItemBackgroundColor") ?? .systemGray5
    }
    static var navigationBarTintColor: UIColor {
        UIColor(named: "NavigationBarTintColor") ?? .systemOrange
    }
    
    static func colorFromRGB (red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(
            red: CGFloat(Float(red) / 255.0),
            green: CGFloat(Float(green) / 255.0),
            blue: CGFloat(Float(blue) / 255.0),
            alpha: CGFloat(1.0))
    }
}
