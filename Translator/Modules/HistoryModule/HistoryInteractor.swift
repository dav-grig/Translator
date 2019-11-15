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
    let storageService: StorageServiceProtocol
    
    private var items = [TranslationItem]()
    private var filteredItems = [TranslationItem]()
    
    init(presenter: HistoryPresenterProtocol, storageService: StorageServiceProtocol) {
        self.presenter = presenter
        self.storageService = storageService
    }
    
    func clearList(completion: () -> Void) {
        storageService.deleteAll(completion: { [weak self] (error) in
            if let error = error {
                self?.presenter.showAlertView(with: error.localizedDescription)
                completion()
                return
            }
            self?.removeCache()
            completion()
        })
    }
    
    func getAllItems() {
        storageService.fetch(completion: { [weak self] (result, error) in
            if let error = error {
                self?.presenter.showAlertView(with: error.localizedDescription)
                return
            }
            if let result = result, !result.isEmpty {
                self?.items = result
                self?.presenter.updateItems()
            }
        })
    }
    
    func filterFor(searchText: String) {
        filteredItems = items.filter({ (item: TranslationItem) -> Bool in
            if item.translationExpression.lowercased().contains(searchText.lowercased()) || item.translationResult.lowercased().contains(searchText.lowercased()) {
                return true
            }
            return false
        })
    }
    
    func items(isFiltered: Bool) -> [TranslationItem] {
        return isFiltered ? filteredItems : items
    }
    
    // MARK: - Private
    
    private func removeCache() {
        items.removeAll()
        filteredItems.removeAll()
    }
}
