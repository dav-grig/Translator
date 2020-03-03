//
//  SelectViewController.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import UIKit

final class SelectViewController: UITableViewController, SelectViewProtocol {

    typealias ConfiguratorProtocol = SelectConfigurator

    var presenter: SelectPresenterProtocol?
    var configurator: ConfiguratorProtocol = SelectConfigurator()

    let languages: [Language] = Language.allCases
    
    private let cellReuseId = "selectedCellReuseId"

    @IBAction func closeButtonTouched(_ sender: Any) {
        presenter?.closeButtonTouched()
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        let lang = languages[indexPath.row]
        configureCell(cell, with: lang)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let language = languages[indexPath.row]
        presenter?.choose(language: language)
    }
    
    // MARK: - Private
    
    private func configureCell(_ cell: UITableViewCell, with language: Language) {
        cell.textLabel?.text = language.description
    }
}
