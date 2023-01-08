//
//  UIColor+Palette.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 7.01.23.
//

import UIKit

extension UIColor {
    static func colorFromRGB (red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(
            red: CGFloat(Float(red) / 255.0),
            green: CGFloat(Float(green) / 255.0),
            blue: CGFloat(Float(blue) / 255.0),
            alpha: CGFloat(1.0))
    }
    static func palette() -> [UIColor] {
        let palette = [
            UIColor.colorFromRGB(red: 207, green: 221, blue: 240),
            UIColor.colorFromRGB(red: 210, green: 250, blue: 239),
            UIColor.colorFromRGB(red: 254, green: 241, blue: 178)
        ]
        return palette
    }
}
