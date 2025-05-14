//
//  TappxErrorManager.swift
//  TappxUIKitExample
//
//  Created by Sara on 13/5/25.
//

import Foundation

struct TappxErrorManager {
    static func message(for errorCode: Int) -> String {
        guard let error = TappxErrorCode(rawValue: errorCode) else {
            return NSLocalizedString("Unknown error", comment: "")
        }
        
        return error.localizedMessage
    }
    
    @objc enum TappxErrorCode: Int {
        case noFill = 0
        case serverError = 1
        case developerError = 2
        case viewInconsistency = 3
        case cancelled = 4
        case noConnection = 5
        
        var localizedMessage: String {
            switch self {
            case .noFill:
                return "error.noFill".localized
            case .serverError:
                return "error.serverError".localized
            case .developerError:
                return "error.developerError".localized
            case .viewInconsistency:
                return "error.viewInconsistency".localized
            case .cancelled:
                return "error.cancelled".localized
            case .noConnection:
                return "error.noConnection".localized
            }
        }
    }
}
