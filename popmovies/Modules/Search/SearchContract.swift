
//
//  SearchContract.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewInterface: BaseViewInterface {
    var presenter: SearchPresenterInterface? { get set }
    
    func setupSearchController()
    
    func showMovies(with movies: [Movie])
    func stopInfiniteScroll()
}

protocol SearchPresenterInterface: BasePresenterInterface {
    
    var view: SearchViewInterface? { get set }
    var interactor: SearchInteractorInputInterface? { get set }
    var wireframe: SearchWireframeInterface? { get set }
    
    func searchMovies(with query: String?)
    
    func didSelectMovie(with movie: Movie)
}

protocol SearchInteractorInputInterface: BaseInteractorInterface {
    var output: SearchInteractorOutputInterface? { get set }
    
    func searchMovie(with query: String, page: Int)
}

protocol SearchInteractorOutputInterface {
    
    func didSearchMovieFetch(_ movies: [Movie], _ totalPages: Int)
    func didSearchMovieError(_ error: DefaultError)
}

protocol SearchWireframeInterface: BaseWireframeInterface {
    
    func presentDetails(for movie: Movie)
    
    static func buildModule() -> UIViewController
}
