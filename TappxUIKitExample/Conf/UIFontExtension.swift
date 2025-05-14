//
//  UIFontExtension.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import UIKit

extension UIFont {
    static func titleFont() -> UIFont {
        return UIFont(name: "IBMPlexSans-SemiBold", size: 22) ?? UIFont.systemFont(ofSize: 22)
    }
    
    static func bodyFont() -> UIFont {
        return UIFont(name: "IBMPlexSans-Mediumk", size: 18) ?? UIFont.systemFont(ofSize: 18)
    }
    
    static func headerFont() -> UIFont {
        return UIFont(name: "ReneBieder-FaktumSemiBold", size: 26) ?? UIFont.systemFont(ofSize: 26, weight: .bold)
    }
    
    static func secondFont() -> UIFont {
        return UIFont(name: "IBMPlexSans-Mediumk", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
}
