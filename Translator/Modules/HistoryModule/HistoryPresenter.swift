//
//  HistoryPresenter.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

class HistoryPresenter: HistoryPresenterProtocol {
    
    weak var view: HistoryViewProtocol!
    var interactor: HistoryInteractorProtocol!
    var router: HistoryRouterProtocol!
    
    func items(isFiltered: Bool) -> [TranslationItem] {
        return interactor.items(isFiltered: isFiltered).reversed()
    }
    
    init(view: HistoryViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        interactor.fetchAllItems()
    }
    
    func updateItems() {
        view.updateItems()
    }
    
    func didSelect(item: TranslationItem) {
        router.show(item: item)
    }
    
    func clearButtonTouched() {
        interactor.clearList { [weak self] in
            self?.view.updateItems()
        }
    }
    
    func filterFor(searchText: String) {
        interactor.filterFor(searchText: searchText)
    }
    
    func showAlertView(with text: String) {
        router.showAlertView(with: text)
    }
    
}
