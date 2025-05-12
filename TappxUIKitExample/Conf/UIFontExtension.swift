//
//  UIFontExtension.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import UIKit

extension UIFont {
    static func titleFont() -> UIFont {
        return UIFont(name: "IBMPlexSans-SemiBold", size: 20) ?? UIFont.systemFont(ofSize: 20)
    }
    
    static func bodyFont() -> UIFont {
        return UIFont(name: "IBMPlexSans-Mediumk", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func headerFont() -> UIFont {
        return UIFont(name: "ReneBieder-FaktumSemiBold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    
    static func secondFont() -> UIFont {
        return UIFont(name: "IBMPlexSans-Mediumk", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }
}
