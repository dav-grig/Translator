//
//  SelectConfigurator.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

final class SelectConfigurator: ConfiguratorProtocol {
    func configure(with viewController: SelectViewController) {
        
        let presenter = SelectPresenter(view: viewController)
        let interactor = SelectInteractor(presenter: presenter)
        let router = SelectRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
