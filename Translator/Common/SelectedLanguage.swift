//
//  SelectedLanguage.swift
//  Translater
//
//  Created by David Grigoryan on 13/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

enum LanguageType {
    case from
    case to
}

struct SelectedLanguage {
    var value: Language
    let type: LanguageType
}
