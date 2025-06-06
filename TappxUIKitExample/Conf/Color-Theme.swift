//
//  Color-Theme.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 5/5/25.
//

import UIKit

struct ColorTheme {
    static let primary = UIColor(hex: "#ff0d58") // Pink
    static let primaryVariant = UIColor(hex: "#330032") // Purple
    static let secondary = UIColor(hex: "#f2f2f2") // Gray
    static let secondaryVariant = UIColor(hex: "#ffffff") // White
    static let scrollBackground = UIColor(hex: "#333333") // Dark grey
    static let darkGray = UIColor(hex: "#e0e0e0") // Gray
    static let switchOn = UIColor(hex: "#7ce080") // Green
    static let switchOff = UIColor(hex: "#606060") // Gray
    
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                if hexColor.count == 8 {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                } else if hexColor.count == 6 {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    a = 1.0
                } else {
                    return nil
                }
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        return nil
    }
}
