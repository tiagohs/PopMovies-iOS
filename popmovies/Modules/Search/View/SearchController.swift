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
    
    // MARK: Constants
    
    let MovieCell                   = R.nib.movieDetailsCellTableView.name
    let MovieCellIdentifier         = "MovieCellIdentifier"
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var presenter: SearchPresenterInterface?
    
    var movies: [Movie] = []
    
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
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCellIdentifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        
        cell.movie = movie
        cell.bindMovieCellDetails(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        self.presenter?.didSelectMovie(with: movie)
    }
    
}

// MARK: SearchViewInterface - Setup Methods

extension SearchController: SearchViewInterface {
    
    func setupUI() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.configureNibs(nibName: MovieCell, identifier: MovieCellIdentifier)
        
        tableView.infiniteScrollIndicatorView = createDefaultActivityIndicator()
        tableView.infiniteScrollTriggerOffset = 500
        tableView.infiniteScrollIndicatorMargin = 20
        
        tableView.addInfiniteScroll { (scrollView) in
            self.presenter?.searchMovies(with: nil)
            
            scrollView.finishInfiniteScroll()
        }
        
        tableView.reloadData()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.layer.borderWidth = 1
        searchController.searchBar.layer.borderColor = UIColor.white.cgColor
        
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

extension SearchController {
    
    func showMovies(with movies: [Movie]) {
        self.movies = movies
        
        self.tableView.reloadData()
        self.tableView.finishInfiniteScroll()
    }
    
    func stopInfiniteScroll() {
        self.tableView.setShouldShowInfiniteScrollHandler { _ -> Bool in
            return false
        }
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
        presenter?.searchMovies(with: searchText)
    }
    
}
