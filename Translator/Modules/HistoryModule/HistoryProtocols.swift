//
//  HistoryProtocols.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

protocol HistoryViewProtocol: class {
    func updateItems()
}

protocol HistoryInteractorProtocol {
    func items(isFiltered: Bool) -> [TranslationItem]
    func getAllItems()
    func clearList(completion: () -> Void)
    func filterFor(searchText: String)
}

protocol HistoryRouterProtocol {
    func show(item: TranslationItem)
    func showAlertView(with text: String)
}

protocol HistoryPresenterProtocol: class {
    func items(isFiltered: Bool) -> [TranslationItem]
    func didSelect(item: TranslationItem)
    func clearButtonTouched()
    func configureView()
    func updateItems()
    func filterFor(searchText: String)
    
    func showAlertView(with text: String)
}
