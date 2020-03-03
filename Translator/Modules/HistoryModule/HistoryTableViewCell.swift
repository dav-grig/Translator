//
//  HistoryTableViewCell.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var expression: UILabel!
    @IBOutlet weak var result: UILabel!
    
    static let reuseId = "historyCellReuseId"
    static let cellHeight = CGFloat(50)
    
    var item: TranslationItem? {
        didSet {
            bindItem()
        }
    }
    
    private func bindItem() {
        guard let item = item else { return }
        
        expression.text = item.translationExpression
        result.text = item.translationResult
    }
}
