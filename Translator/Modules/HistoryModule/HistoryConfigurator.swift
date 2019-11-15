//
//  HistoryConfigurator.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

class HistoryConfigurator: ConfiguratorProtocol {
    
    func configure(with viewController: HistoryViewController) {
        
        let storage = StorageService()
        
        let presenter = HistoryPresenter(view: viewController)
        let interactor = HistoryInteractor(presenter: presenter, storageService: storage)
        let router = HistoryRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
