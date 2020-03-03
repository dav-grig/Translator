//
//  CoreDataStore.swift
//  Translater
//
//  Created by David Grigoryan on 13/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStore {
    
    static let instance = CoreDataStore()
    
    private let translationItemEntity = String(describing: ManagedTranslationItem.self)
    
    private let createsErrorText = "Can not creates the translation item in storage"
    private let fetchesErrorText = "Can not fetches the translation items from storage"
    private let deleteAllErrorText = "Can not delete all translation items from storage"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    func create(translationItem: TranslationItem, completion: (TranslationError?) -> Void) {
        let context = persistentContainer.viewContext
        do {
            guard let item = NSEntityDescription.insertNewObject(forEntityName: translationItemEntity,
                                                                 into: context) as? ManagedTranslationItem else {
                                                                    completion(TranslationError.databaseError(createsErrorText))
                                                                    return
            }
            item.from(translationItem: translationItem)
            try saveContext()
            completion(nil)
        } catch {
            completion(TranslationError.databaseError(createsErrorText))
        }
    }
    
    func deleteAll(completion: (TranslationError?) -> Void) {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: translationItemEntity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(deleteRequest)
            try saveContext()
            completion(nil)
        } catch {
            completion(TranslationError.databaseError(deleteAllErrorText))
        }
    }
    
    func fetch(completion: @escaping ([TranslationItem]?, TranslationError?) -> Void) {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: translationItemEntity)
        do {
            let fetchedResult = try context.fetch(request)
            guard let result = fetchedResult as? [ManagedTranslationItem] else {
                completion(nil, TranslationError.databaseError(fetchesErrorText))
                return
            }
            completion(result.compactMap{$0.toTranslationItem()}, nil)
        } catch {
            completion(nil, TranslationError.databaseError(fetchesErrorText))
        }
    }
    
    // MARK: - Private
    
    private func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
        }
    }
}

extension ManagedTranslationItem {
    func toTranslationItem() -> TranslationItem? {
        guard let translationExpression = translationExpression,
            let translationResult = translationResult,
            let toLanguage = toLanguage,
            let fromLanguage = fromLanguage,
            let from = Language(rawValue: fromLanguage),
            let to = Language(rawValue: toLanguage) else {
                return nil
        }
        return TranslationItem(translationExpression: translationExpression,
                               translationResult: translationResult,
                               fromLanguage: from,
                               toLanguage: to)
    }
    
    func from(translationItem: TranslationItem) {
        translationExpression = translationItem.translationExpression
        translationResult = translationItem.translationResult
        toLanguage = translationItem.toLanguage.toCode()
        fromLanguage = translationItem.fromLanguage.toCode()
    }
}


