//
//  TraslationProtocols.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

protocol TranslationViewProtocol: class {
    func show(item: TranslationItem)
    func updateButtons()
    
    var presenter: TranslationPresenterProtocol? { get }
}

protocol TranslationInteractorProtocol {
    func translate()
    
    var expression: String? { get set }
    var translationResult: String? { get }
    var fromLanguage: Language { get }
    var toLanguage: Language { get }
    
    func set(language: SelectedLanguage)
    func set(item: TranslationItem)
    
    func swap()
}

protocol TranslationRouterProtocol {
    func updateHistoryList()
    func showAlertView(with text: String)
    func showSelectLanguageView(_ language: SelectedLanguage)
}

protocol TranslationPresenterProtocol: LanguageSetterProtocol {
    func itemsListHasBeenUpdated()
    func updateTranslationResult()
    
    func swapButtonTouched()
    func setExpression(_ value: String)
    
    var fromLanguageTitle: String? { get }
    var toLanguageTitle: String? { get }
    
    func fromButtonTouched()
    func toButtonTouched()
    
    func set(item: TranslationItem)
    
    func showAlertView(with text: String)
}

protocol LanguageSetterProtocol: class {
    func set(language: SelectedLanguage)
}
