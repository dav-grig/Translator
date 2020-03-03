//
//  TranslationInteractor.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

final class TranslationInteractor: TranslationInteractorProtocol {
    
    weak var presenter: TranslationPresenterProtocol?
    
    let networkService: NetworkServiceProtocol
    let storageService: StorageServiceProtocol
    
    var expression: String? {
        didSet {
            translate()
        }
    }
    var fromLanguage: Language = .en
    var toLanguage: Language = .ru
    var translationResult: String?
    
    init(presenter: TranslationPresenterProtocol,
         networkService: NetworkServiceProtocol,
         storageService: StorageServiceProtocol) {
        
        self.presenter = presenter
        self.networkService = networkService
        self.storageService = storageService
    }
    
    func swap() {
        let from = fromLanguage
        let to = toLanguage
        toLanguage = from
        fromLanguage = to
        
        let exp = expression
        let result = translationResult
        
        expression = result
        translationResult = exp
        
        translate()
    }
    
    func translate() {
        guard let expression = expression else { return }
        
        let request = TranslationRequest(expression: expression, from: fromLanguage, to: toLanguage)
        networkService.translate(request: request, completion: { [weak self] (result, error) in
            guard let self = self,
                let presenter = self.presenter else { return }
            
            if let error = error {
                self.presenter?.showAlertView(with: error.localizedDescription)
                return
            }
            
            guard let translationResult = result,
                let expression = self.expression else { return }
            
            let item = TranslationItem(translationExpression: expression,
                                       translationResult: translationResult,
                                       fromLanguage: self.fromLanguage,
                                       toLanguage: self.toLanguage)
            
            self.storageService.create(item: item, completion: { error in
                if let error = error {
                    presenter.showAlertView(with: error.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    if expression == request.expression &&
                        self.fromLanguage == request.from &&
                        self.toLanguage == request.to {
                        
                        self.translationResult = translationResult
                        presenter.updateTranslationResult()
                    }
                    presenter.itemsListHasBeenUpdated()
                }
            })
        })
    }
    
    func set(language: SelectedLanguage) {
        switch language.type {
        case .from:
            if toLanguage == language.value {
                toLanguage = fromLanguage
            }
            fromLanguage = language.value
        case .to:
            if fromLanguage == language.value {
                fromLanguage = toLanguage
            }
            toLanguage = language.value
        }
        translate()
    }
    
    func set(item: TranslationItem) {
        expression = item.translationExpression
        translationResult = item.translationResult
        fromLanguage = item.fromLanguage
        toLanguage = item.toLanguage
        
        presenter?.updateTranslationResult()
    }
    
}
