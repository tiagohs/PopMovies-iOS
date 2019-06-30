//
//  HomeContract.swift
//  popmovies
//
//  Created by Tiago Silva on 11/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

protocol HomeViewInterface: BaseViewInterface {
    
    var presenter: HomePresenterInterface? { get set }
    
    func showNowPlayingMovies(with movies: [Movie])
    func showPopularMovies(with movies: [Movie])
    func showTopRatedMovies(with movies: [Movie])
    func showUpcomingMovies(with movies: [Movie])
}

protocol HomePresenterInterface: BasePresenterInterface {
    
    var view: HomeViewInterface? { get set }
    var interactor: HomeInteractorInputInterface? { get set }
    var wireframe: HomeWireframaInterface? { get set }
    
    func fetchPopularMovies()
    func fetchNowPlayingMovies()
    func fetchTopRatedMovies()
    func fetchUpcomingMovies()
    
    func didSelectSeeAllPopularMovies()
    func didSelectSeeAllTopRatedMovies()
    func didSelectSeeAllUpcomingMovies()
    func didSelectMovie(_ movie: Movie)
}

protocol HomeInteractorInputInterface: BaseInteractorInterface {
    var output: HomeInteractorOutputInterface? { get set }
    
    func fetchPopularMovies()
    func fetchNowPlayingMovies()
    func fetchTopRatedMovies()
    func fetchUpcomingMovies()
}

protocol HomeInteractorOutputInterface {
    
    func popularMoviesDidFetch(_ movies: [Movie])
    func nowPlayingMoviesDidFetch(_ movies: [Movie])
    func topRatedMoviesDidFetch(_ movies: [Movie])
    func upcomingMoviesDidFetch(_ movies: [Movie])
    
    func popularMoviesDidError(_ error: DefaultError)
    func nowPlayingMoviesDidError(_ error: DefaultError)
    func topRatedMoviesDidError(_ error: DefaultError)
    func upcomingMoviesDidError(_ error: DefaultError)
}

protocol HomeWireframaInterface {
    
    var viewController: UIViewController? { get set }
    
    func presentDetails(for movie: Movie)
    func pushToPopularMoviesList()
    func pushToTopRatedMoviesList()
    func pushToUpcomingMoviesList()
    
    static func buildModule() -> UIViewController
}
