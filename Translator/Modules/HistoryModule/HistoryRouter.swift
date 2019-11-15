//
//  HistoryRouter.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation
import UIKit

class HistoryRouter: HistoryRouterProtocol {
    weak var viewController: HistoryViewController!
    
    init(viewController: HistoryViewController) {
        self.viewController = viewController
    }
    
    func show(item: TranslationItem) {
        if let translationController = viewController.tabBarController?.viewControllers?[0] as? TranslationViewProtocol {
            translationController.presenter.set(item: item)
            viewController.tabBarController?.selectedIndex = 0
        }
    }
    
    func showAlertView(with text: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "", message: text, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in })
            self.viewController.present(alertController, animated: true, completion: nil)
        }
    }
}
