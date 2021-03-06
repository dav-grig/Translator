//
//  TranslationPresenter.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

final class TranslationPresenter: TranslationPresenterProtocol, LanguageSetterProtocol {
    
    weak var view: TranslationViewProtocol?
    var interactor: TranslationInteractorProtocol?
    var router: TranslationRouterProtocol?
    
    init(view: TranslationViewProtocol) {
        self.view = view
    }
    
    var fromLanguageTitle: String? {
        return interactor?.fromLanguage.description
    }
    
    var toLanguageTitle: String? {
        return interactor?.toLanguage.description
    }
    
    func itemsListHasBeenUpdated() {
        router?.updateHistoryList()
    }
    
    func updateTranslationResult() {
        guard let view = view,
            let interactor = interactor,
            let translationResult = interactor.translationResult,
            let translationExpression = interactor.expression else { return }
        
        let translationItem = TranslationItem(translationExpression: translationExpression,
                                              translationResult: translationResult,
                                              fromLanguage: interactor.fromLanguage,
                                              toLanguage: interactor.toLanguage)
        
        view.show(item: translationItem)
    }
    
    func setExpression(_ value: String) {
        interactor?.expression = value
    }
    
    func swapButtonTouched() {
        interactor?.swap()
        view?.updateButtons()
    }
    
    func fromButtonTouched() {
        guard let interactor = interactor else { return }
        
        router?.showSelectLanguageView(SelectedLanguage(value: interactor.fromLanguage, type: .from))
    }
    
    func toButtonTouched() {
        guard let interactor = interactor else { return }

        router?.showSelectLanguageView(SelectedLanguage(value: interactor.toLanguage, type: .to))
    }
    
    func set(item: TranslationItem) {
        interactor?.set(item: item)
    }
    
    func set(language: SelectedLanguage) {
        interactor?.set(language: language)
        view?.updateButtons()
    }
    
    func showAlertView(with text: String) {
        router?.showAlertView(with: text)
    }
}
