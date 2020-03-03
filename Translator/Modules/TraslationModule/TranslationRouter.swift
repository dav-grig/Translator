//
//  TranslationRouter.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation
import UIKit

final class TranslationRouter: TranslationRouterProtocol {
    
    weak var viewController: TranslationViewController?
    
    init(viewController: TranslationViewController) {
        self.viewController = viewController
    }
    
    func updateHistoryList() {
        if let navigationController = viewController?.tabBarController?.viewControllers?[1] as? UINavigationController,
            let historyController = navigationController.topViewController as? HistoryViewProtocol {

            historyController.updateItems()
        }
    }
    
    func showAlertView(with text: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "", message: text, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in })
            
            self.viewController?.present(alertController, animated: true)
        }
    }
    
    func showSelectLanguageView(_ language: SelectedLanguage) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let selectLanguageViewController = storyboard.instantiateViewController(withIdentifier: "selectLanguageViewController") as? UINavigationController,
            let selectViewController = selectLanguageViewController.topViewController as? SelectViewController else {
                return
        }
        
        selectViewController.configurator = SelectConfigurator()
        selectViewController.configurator.configure(with: selectViewController)
        selectViewController.presenter?.selectedLanguage = language
        selectViewController.presenter?.languageSetter = viewController?.presenter
        
        viewController?.present(selectLanguageViewController, animated: true)
    }
}
