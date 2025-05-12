//
//  StringExtension.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import Foundation

extension String {
    var localized: String {
          return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
      }
    
}
