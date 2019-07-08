//
//  HomePresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 11/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

// MARK: HomePresenter

class HomePresenter {
    
    // MARK: Properties
    
    var view: HomeViewInterface?
    var interactor: HomeInteractorInputInterface?
    var wireframe: HomeWireframaInterface?
    
    init(view: HomeViewInterface?) {
        self.view = view
    }
}

// MARK: HomePresenterInterface - Lifecycle methods

extension HomePresenter: HomePresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        
        self.fetchNowPlayingMovies()
        self.fetchPopularMovies()
        self.fetchTopRatedMovies()
        self.fetchUpcomingMovies()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.view?.hideNavigationBar(animated)
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.view?.showNavigationBar(animated)
    }
    
}

// MARK: HomePresenterInterface - Fetch methods

extension HomePresenter {
    
    func fetchPopularMovies() {
        interactor?.fetchPopularMovies()
    }
    
    func fetchNowPlayingMovies() {
        interactor?.fetchNowPlayingMovies()
    }
    
    func fetchTopRatedMovies() {
        interactor?.fetchTopRatedMovies()
    }
    
    func fetchUpcomingMovies() {
        interactor?.fetchUpcomingMovies()
    }
}


// MARK: HomePresenterInterface - User click methods

extension HomePresenter {
    
    func didSelectSeeAllPopularMovies() {
        wireframe?.pushToPopularMoviesList()
    }
    
    func didSelectSeeAllTopRatedMovies() {
        wireframe?.pushToTopRatedMoviesList()
    }
    
    func didSelectSeeAllUpcomingMovies() {
        wireframe?.pushToUpcomingMoviesList()
    }
    
    func didSelectMovie(_ movie: Movie) {
        wireframe?.presentDetails(for: movie)
    }
    
    func didSearchClicked() {
        wireframe?.presentSearch()
    }
}

// MARK: HomeInteractorOutputInterface

extension HomePresenter: HomeInteractorOutputInterface {
    
    func popularMoviesDidFetch(_ movies: [Movie]) {
        self.view?.showPopularMovies(with: movies)
    }
    
    func nowPlayingMoviesDidFetch(_ movies: [Movie]) {
        self.view?.showNowPlayingMovies(with: movies)
    }
    
    func topRatedMoviesDidFetch(_ movies: [Movie]) {
        self.view?.showTopRatedMovies(with: movies)
    }
    
    func upcomingMoviesDidFetch(_ movies: [Movie]) {
        self.view?.showUpcomingMovies(with: movies)
    }
    
    func popularMoviesDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
    
    func nowPlayingMoviesDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
    
    func topRatedMoviesDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
    
    func upcomingMoviesDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
    
}
