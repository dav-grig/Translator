//
//  StorageService.swift
//  Translater
//
//  Created by David Grigoryan on 13/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

protocol StorageServiceProtocol {
    func create(item: TranslationItem, completion: (TranslationError?) -> Void)
    func deleteAll(completion: (TranslationError?) -> Void)
    func fetch(completion: @escaping ([TranslationItem]?, TranslationError?) -> Void)
}

final class StorageService: StorageServiceProtocol {
    private let coreData = CoreDataStore.instance
    
    func create(item: TranslationItem, completion: (TranslationError?) -> Void) {
        return coreData.create(translationItem: item, completion: completion)
    }
    
    func deleteAll(completion: (TranslationError?) -> Void) {
        return coreData.deleteAll(completion: completion)
    }
    
    func fetch(completion: @escaping ([TranslationItem]?, TranslationError?) -> Void) {
        return coreData.fetch(completion: completion)
    }
}
