//
//  Language.swift
//  Translater
//
//  Created by David Grigoryan on 13/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

enum Language: String, CaseIterable {
    case ru = "ru"
    case en = "en"
    case hy = "hy"
    
    func toCode() -> String {
        return self.rawValue
    }
    
    var description: String {
        switch self {
        case .ru: return "Russian"
        case .en: return "English"
        case .hy: return "Armenian"
        }
    }
}
