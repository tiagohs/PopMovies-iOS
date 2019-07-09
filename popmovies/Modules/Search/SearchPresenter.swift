
//
//  SearchPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: SearchPresenter

class SearchPresenter {
    
    var view: SearchViewInterface?
    var interactor: SearchInteractorInputInterface?
    var wireframe: SearchWireframeInterface?
    
    var page: Int = 1
    var totalPage: Int = 1
    
    var movies: [Movie] = []
    
    var previousQuery: String = ""
    var currentQuery: String = ""
    
    var isNewSearch: Bool = false
    
    init(view: SearchViewInterface?) {
        self.view = view
    }
    
}

// MARK: HomePresenterInterface - Lifecycle methods

extension SearchPresenter: SearchPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        self.view?.setupSearchController()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

// MARK: HomePresenterInterface - Fetch methods

extension SearchPresenter {
    
    func searchMovies(with query: String? = nil) {
        if query != nil {
            self.currentQuery = query!
        }
        
        self.isNewSearch = self.currentQuery != self.previousQuery
        
        if page > totalPage {
            view?.stopInfiniteScroll()
            return
        }
        
        if self.page == 1 && self.isNewSearch {
            self.movies = []
            self.view?.showActivityIndicator()
        }
        
        if query != nil { self.previousQuery = query! }
        
        self.interactor?.searchMovie(with: self.currentQuery, page: page)
    }
    
}

// MARK: HomePresenterInterface - User click methods

extension SearchPresenter {
    
    func didSelectMovie(with movie: Movie) {
        wireframe?.presentDetails(for: movie)
    }
    
}

// MARK: SearchInteractorOutputInterface

extension SearchPresenter: SearchInteractorOutputInterface {
    
    func didSearchMovieFetch(_ movies: [Movie], _ totalPages: Int) {
        
        if self.page == 1 {
            self.view?.hideActivityIndicator()
        }
        
        if self.isNewSearch {
            setupNewSearch(movies, totalPages)
        } else {
            setupNewPage(movies)
        }
        
        self.view?.showMovies(with: self.movies)
    }
    
    private func setupNewSearch(_ movies: [Movie], _ totalPages: Int) {
        self.totalPage = totalPages
        self.page = 2
        
        self.movies = movies
    }
    
    private func setupNewPage(_ movies: [Movie]) {
        self.page += 1
        
        if self.movies.isEmpty {
            self.movies = movies
        } else {
            self.movies += movies
        }
    }
    
    func didSearchMovieError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
}
