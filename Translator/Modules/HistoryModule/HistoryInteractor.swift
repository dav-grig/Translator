//
//  HistoryInteractor.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

class HistoryInteractor: HistoryInteractorProtocol {
    
    weak var presenter: HistoryPresenterProtocol!
    let historyService: HistoryServiceProtocol
    
    init(presenter: HistoryPresenterProtocol, historyService: HistoryServiceProtocol) {
        self.presenter = presenter
        self.historyService = historyService
    }
    
    func clearList(completion: () -> Void) {
        historyService.deleteAll(completion: { [weak self] (error) in
            if let error = error {
                self?.presenter.showAlertView(with: error.localizedDescription)
                completion()
                return
            }
            completion()
        })
    }
    
    func fetchAllItems() {
        historyService.fetch(completion: { [weak self] (error) in
            if let error = error {
                self?.presenter.showAlertView(with: error.localizedDescription)
                return
            }
            self?.presenter.updateItems()
        })
    }
    
    func filterFor(searchText: String) {
        historyService.filterFor(searchText: searchText)
    }
    
    func items(isFiltered: Bool) -> [TranslationItem] {
        return historyService.items(isFiltered: isFiltered)
    }
}
