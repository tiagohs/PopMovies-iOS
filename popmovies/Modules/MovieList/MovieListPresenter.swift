//
//  MovieListPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: MovieListPresenter

class MovieListPresenter {
    
    var view: MovieListViewInterface?
    var interactor: MovieListInteractorInputInterface?
    var wireframe: MovieListWireframeInterface?
    
    var page: Int = 1
    var totalPage: Int = 1
    
    var movies: [Movie]?
    
    var parameters: [String : String]?
    var url: String?
    
    init(view: MovieListViewInterface?) {
        self.view = view
    }
    
}

// MARK: MovieListPresenterInterface - Lifecycle methods

extension MovieListPresenter: MovieListPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        
        if movies == nil {
            self.fetchMovies()
            return
        }
        
        view?.stopInfiniteScroll()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
}

// MARK: MovieListPresenterInterface - Fetch methods

extension MovieListPresenter {
    
    func fetchMovies() {
        if page > totalPage {
            view?.stopInfiniteScroll()
            return
        }
        
        guard let url = url else {
            self.view?.onError(message: "Houve um erro ao buscar os filmes.")
            return
        }
        guard let baseParameters = parameters else {
            self.view?.onError(message: "Houve um erro ao buscar os filmes.")
            return
        }
        
        let parameters = baseParameters.merge(with: [
            TMDB.Parameters.page: String(page)
            ])
        
        interactor?.fetchMovies(from: url, with: parameters)
    }
}

// MARK: MovieListPresenterInterface - User click methods

extension MovieListPresenter {
    
    func didSelectMovie(_ movie: Movie) {
        wireframe?.presentDetails(for: movie)
    }
    
    func didSearchClicked() {
        wireframe?.presentSearch()
    }
    
}

// MARK: MovieListInteractorOutputInterface

extension MovieListPresenter: MovieListInteractorOutputInterface {
    
    func moviesDidFetch(_ movies: [Movie], totalPages: Int) {
        self.totalPage = totalPages
        self.page += 1
        
        if self.movies != nil {
            self.movies! += movies
        } else {
            self.movies = movies
        }
        
        self.view?.showMovies(with: self.movies!)
    }
    
    func moviesDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
    
}
