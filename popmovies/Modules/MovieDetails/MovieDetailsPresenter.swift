//
//  MovieDetailsPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

// MARK: MovieDetailsPresenter

class MovieDetailsPresenter {
    
    var view: MovieDetailsViewInterface?
    var interactor: MovieDetailsInteractorInputInterface?
    var wireframe: MovieDetailsWireframeInterface?
    
    init(view: MovieDetailsViewInterface?) {
        self.view = view
    }
    
}

// MARK: MovieDetailsPresenterInterface - Lifecycle methods

extension MovieDetailsPresenter: MovieDetailsPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
        self.interactor = nil
        self.view = nil
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
}

// MARK: MovieDetailsPresenterInterface - Fetch methods

extension MovieDetailsPresenter {
    
    func fetchMovieDetails(movie: Movie?) {
        guard let movie = movie else {
            return
        }
        
        self.interactor?.fetchMovieDetails(movie: movie)
    }
}

// MARK: MovieDetailsPresenterInterface - User click methods

extension MovieDetailsPresenter {
    
    func didSelectPerson(_ person: Person) {
        wireframe?.presentDetails(for: person)
    }
    
    func didSelectMovie(_ movie: Movie) {
        wireframe?.presentDetails(for: movie)
    }
    
    func didSelectLink(url: String) {
        wireframe?.presentExternalLink(from: url)
    }
    
    func didSelectImage(_ image: Image, _ allImages: [Image], _ movie: Movie?) {
        guard let movie = movie else {
            return
        }
        
        wireframe?.presentImageViewer(for: image, allImages, movie)
    }
    
    func didSelectVideo(_ video: Video, _ allVideos: [Video], _ movie: Movie?) {
        guard let movie = movie else {
            return
        }
        
        wireframe?.presentVideoViewer(for: video, allVideos, movie)
    }
    
    func didSeeAllVideosClicked(_ allVideos: [Video], _ movie: Movie?) {
        guard let movie = movie else {
            return
        }
        
        wireframe?.pushToVideoList(allVideos, movie)
    }
    
    func didSeeAllWallpapersClicked(_ allImages: [Image], _ movie: Movie?) {
        guard let movie = movie else {
            return
        }
        
        wireframe?.pushToImageList(allImages, movie)
    }
    
    func didSeeAllRelatedMoviesClicked(_ movie: Movie?) {
        guard let movie = movie else {
            return
        }
        
        wireframe?.pushToRelatedMovies(with: movie)
    }
    
    func didSelectGenre(_ genre: Genre) {
        wireframe?.pushToMovieListByGenre(genre)
    }
}

// MARK: MovieDetailsInteractorOutputInterface

extension MovieDetailsPresenter: MovieDetailsInteractorOutputInterface {
    
    func movieDetailsDidFetch(_ movie: Movie) {
        self.view?.showMovie(with: movie)
    }
    
    func movieRankingsDidFetch(_ movie: MovieOMDB) {
        self.view?.showMovieRankings(with: movie)
    }
    
    func movieDetailsDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
    
    func movieRankingsDidFetch(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
    
}
