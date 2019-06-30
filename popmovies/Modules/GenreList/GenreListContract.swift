//
//  GenresContract.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

protocol GenreListViewInterface: BaseViewInterface {
    
    var presenter: GenreListPresenterInterface? { get set }
    
    func showGenres(with genres: [Genre])
}

protocol GenreListPresenterInterface: BasePresenterInterface {
    
    var view: GenreListViewInterface? { get set }
    var interactor: GenreListInteractorInputInterface? { get set }
    var wireframe: GenreListWireframeInterface? { get set }
    
    func fetchGenres()
    
    func didSelectGenre(_ genre: Genre)
}

protocol GenreListInteractorInputInterface: BaseInteractorInterface {
    var output: GenreListInteractorOutputInterface? { get set }

    func fetchGenres()
}

protocol GenreListInteractorOutputInterface {
    
    func genresDidFetch(_ genres: [Genre])
    
    func genresDidError(_ error: DefaultError)
}

protocol GenreListWireframeInterface {
    
    var viewController: UIViewController? { get set }
    
    func pushToMovieListByGenre(_ genre: Genre)
    
    static func buildModule() -> UIViewController
}

