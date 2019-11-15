//
//  SelectInteractor.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

class SelectInteractor: SelectInteractorProtocol {
    weak var presenter: SelectPresenterProtocol!
    
    init(presenter: SelectPresenterProtocol) {
        self.presenter = presenter
    }
}
