//
//  HistoryService.swift
//  Translator
//
//  Created by David Grigoryan on 15/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

protocol HistoryServiceProtocol {
    func create(item: TranslationItem, completion: (TranslationError?) -> Void)
    func deleteAll(completion: (TranslationError?) -> Void)
    func fetch(completion: @escaping (TranslationError?) -> Void)
    func filterFor(searchText: String)
    func items(isFiltered: Bool) -> [TranslationItem]
}

final class HistoryService: HistoryServiceProtocol {
    
    private let storageService: StorageServiceProtocol = StorageService()
    private var items = [TranslationItem]()
    private var filteredItems = [TranslationItem]()
    
    func create(item: TranslationItem, completion: (TranslationError?) -> Void) {
        storageService.create(item: item, completion: completion)
    }
    
    func deleteAll(completion: (TranslationError?) -> Void) {
        storageService.deleteAll {  [weak self] (error) in
            if error == nil {
                self?.removeCache()
            }
            completion(error)
        }
    }
    
    func fetch(completion: @escaping (TranslationError?) -> Void) {
        storageService.fetch { [weak self] (result, error) in
            if let result = result, error == nil {
                self?.items = result
            }
            completion(error)
        }
    }
    
    func items(isFiltered: Bool) -> [TranslationItem] {
        return isFiltered ? filteredItems : items
    }
    
    func filterFor(searchText: String) {
        filteredItems = items.filter { (item: TranslationItem) -> Bool in
            if item.translationExpression.lowercased().contains(searchText.lowercased()) || item.translationResult.lowercased().contains(searchText.lowercased()) {
                return true
            }
            return false
        }
    }
    
    // MARK: - Private
    
    private func removeCache() {
        items.removeAll()
        filteredItems.removeAll()
    }
}
