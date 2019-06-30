//
//  GenresPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: GenreListPresenter

class GenreListPresenter {
    
    // MARK: Properties
    
    var view: GenreListViewInterface?
    var interactor: GenreListInteractorInputInterface?
    var wireframe: GenreListWireframeInterface?
    
    var genres: [Genre] = []
    
    init(view: GenreListViewInterface?) {
        self.view = view
    }
    
}

// MARK: GenresPresenterInterface - Lifecycle methods

extension GenreListPresenter: GenreListPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        
        self.fetchGenres()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
        self.interactor = nil
        self.view = nil
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
}

// MARK: GenresPresenterInterface - Fetch methods

extension GenreListPresenter {
    
    func fetchGenres() {
        interactor?.fetchGenres()
    }
}

// MARK: GenresPresenterInterface - User click methods

extension GenreListPresenter {
    
    func didSelectGenre(_ genre: Genre) {
        wireframe?.pushToMovieListByGenre(genre)
    }
}

// MARK: GenresInteractorOutputInterface

extension GenreListPresenter: GenreListInteractorOutputInterface {
    
    func genresDidFetch(_ genres: [Genre]) {
        self.genres = genres
        
        self.view?.showGenres(with: genres)
    }
    
    func genresDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
}
