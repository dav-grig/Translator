//
//  TranslationConfigurator.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

class TranslationConfigurator: ConfiguratorProtocol {
    func configure(with viewController: TranslationViewController) {
        
        let network = NetworkService()
        let storage = StorageService()
        
        let presenter = TranslationPresenter(view: viewController)
        let interactor = TranslationInteractor(presenter: presenter, networkService: network, storageService: storage)
        let router = TranslationRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
