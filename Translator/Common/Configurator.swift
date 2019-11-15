//
//  Configurator.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

protocol ConfiguratorProtocol {
    associatedtype CommonViewController
    func configure(with viewController: CommonViewController)
}
