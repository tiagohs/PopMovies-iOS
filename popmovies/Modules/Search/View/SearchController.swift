//
//  SearchController.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//


import UIKit

// MARK: SearchController: BaseViewController

class SearchController: BaseViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var presenter: SearchPresenterInterface?
    
    let searchController = UISearchController(searchResultsController: nil)
}

// MARK: Lifecycle Methods

extension SearchController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.presenter?.viewDidDisappear(animated)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

// MARK: SearchViewInterface - Setup Methods

extension SearchController: SearchViewInterface {
    
    func setupUI() {
        
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.showsCancelButton = true
        
        if let txfSearchField = searchController.searchBar.value(forKey: "_searchField") as? UITextField {
            txfSearchField.borderStyle = .none
            txfSearchField.layer.cornerRadius = 10
            txfSearchField.clipsToBounds = true
            txfSearchField.backgroundColor = ViewUtils.UIColorFromHEX(hex: "#F8F8F8")
        }
        
        searchController.searchBar.resignFirstResponder()
        if let cancelButton = searchController.searchBar.value(forKey: "_cancelButton") as? UIButton {
            cancelButton.addTarget(self, action: #selector(didCancelClicked), for: .touchUpInside)
        }

        tableView.tableHeaderView = searchController.searchBar
    }
    
    @objc func didCancelClicked(_ sender: AnyObject?) {
        self.hero.dismissViewController()
    }
    
}


extension SearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return
        }
        
        self.searchMovies(for: searchText)
    }
    
    func searchMovies(for searchText: String) {
        
    }
    
}
