//
//  TranslationError.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

enum TranslationError: Error, CustomStringConvertible {
    case serverError(code: Int, description: String?)
    case invalidServerUrl
    case unknowServerError
    case parsingError(reason: String)
    case databaseError(String)
    
    public var description: String {
        switch self {
        case .serverError(let code, let description):
            let code = "\(code)"
            return code + ((description == nil) ? "" : ": \(description!)")
        case .invalidServerUrl:
            return "Invalid server URL"
        case .unknowServerError:
            return "Unknown server error"
        case .parsingError(let reason):
            return "Could not parse server data (\(reason))"
        case .databaseError(let reason):
            return "Database error: \(reason)"
        }
    }
}
