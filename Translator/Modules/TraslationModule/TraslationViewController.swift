//
//  TraslationViewController.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController, TranslationViewProtocol, UITextFieldDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var inputSuperView: UIView!
    
    typealias ConfiguratorProtocol = TranslationConfigurator

    var presenter: TranslationPresenterProtocol!
    var configurator: ConfiguratorProtocol = TranslationConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
        setupUI()
    }
    
    func updateButtons() {
        fromButton.setTitle(presenter.fromLanguageTitle, for: .normal)
        toButton.setTitle(presenter.toLanguageTitle, for: .normal)
    }
    
    func show(item: TranslationItem) {
        inputTextField.text = item.translationExpression
        outputLabel.text = item.translationResult
        fromButton.setTitle(item.fromLanguage.description, for: .normal)
        toButton.setTitle(item.toLanguage.description, for: .normal)
    }
    
    @IBAction func fromButtonAction(_ sender: Any) {
        presenter.fromButtonTouched()
    }
    
    @IBAction func swapButtonAction(_ sender: Any) {
        presenter.swapButtonTouched()
    }
    
    @IBAction func toButtonAction(_ sender: Any) {
        presenter.toButtonTouched()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count > 0 else {
            return false
        }
        textField.resignFirstResponder()
        
        presenter.setExpression(text)
        
        return false
    }
    
    // MARK: - Private
    
    private func setupUI() {
        updateButtons()
        
        contentView.layer.cornerRadius = 10
        
        inputTextField.returnKeyType = .send
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePressGesture(_:)))
        inputSuperView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handlePressGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        inputTextField.becomeFirstResponder()
    }
}
