//
//  SelectRouter.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

final class SelectRouter: SelectRouterProtocol {
    
    weak var viewController: SelectViewController?
    
    init(viewController: SelectViewController) {
        self.viewController = viewController
    }
    
    func select(language: SelectedLanguage) {
        viewController?.presenter?.languageSetter?.set(language: language)
    }
    
    func closeController() {
        viewController?.dismiss(animated: true)
    }
}
