//
//  HistoryViewController.swift
//  Translater
//
//  Created by David Grigoryan on 14/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import UIKit

final class HistoryViewController: UITableViewController, HistoryViewProtocol {
    typealias ConfiguratorProtocol = HistoryConfigurator
    
    var presenter: HistoryPresenterProtocol?
    var configurator: ConfiguratorProtocol = HistoryConfigurator()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.configureView()
    }
    
    func updateItems() {
        tableView.reloadData()
    }
    
    @IBAction func clearButtonTouched(_ sender: Any) {
        presenter?.clearButtonTouched()
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.items(isFiltered: isFiltering).count else {
            fatalError("table view number of rows at \(section) section wasn't set for a HistoryViewController")
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseId, for: indexPath) as? HistoryTableViewCell else {
            fatalError("table view cell at \(indexPath.row) row wasn't set for a HistoryViewController")
        }
        let item = presenter?.items(isFiltered: isFiltering)[indexPath.row]
        configure(cell: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let presenter = presenter else { return }
        
        let item = presenter.items(isFiltered: isFiltering)[indexPath.row]
        presenter.didSelect(item: item)
    }
    
    // MARK: - Private
    
    private func configure(cell: HistoryTableViewCell, with item: TranslationItem?) {
        cell.item = item
    }
    
    private func setupUI() {
        tableView.rowHeight = HistoryTableViewCell.cellHeight
        setupSearchController()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - UISearch Results Updating Delegate

extension HistoryViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        presenter?.filterFor(searchText: text)
        
        updateItems()
    }
}

