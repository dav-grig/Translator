//
//  SelectProtocols.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

protocol SelectViewProtocol: class {
    
}

protocol SelectPresenterProtocol: class {
    var selectedLanguage: SelectedLanguage? { get set }
    var languageSetter: LanguageSetterProtocol? { get set }

    func choose(language: Language)
    func closeButtonTouched()
}

protocol SelectInteractorProtocol {
    
}

protocol SelectRouterProtocol {
    func select(language: SelectedLanguage)
    func closeController()
}
