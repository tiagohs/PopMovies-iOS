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
    
    var movie: Movie? = nil
    var movieRankings: MovieOMDB? = nil
    
    init(view: MovieDetailsViewInterface?) {
        self.view = view
    }
    
}

// MARK: MovieDetailsPresenterInterface - Lifecycle methods

extension MovieDetailsPresenter: MovieDetailsPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        
        self.fetchMovieDetails()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
}

// MARK: MovieDetailsPresenterInterface - Fetch methods

extension MovieDetailsPresenter {
    
    func fetchMovieDetails() {
        guard let movie = self.movie else {
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
    
    func didSelectImage(_ image: Image, _ allImages: [Image], indexPath: IndexPath) {
        guard let movie = self.movie else {
            return
        }
        
        wireframe?.presentImageViewer(for: image, allImages, movie, indexPath: indexPath)
    }
    
    func didSelectVideo(_ video: Video, _ allVideos: [Video]) {
        guard let movie = self.movie else {
            return
        }
        
        wireframe?.presentVideoViewer(for: video, allVideos, movie)
    }
    
    func didSeeAllVideosClicked(_ allVideos: [Video]) {
        guard let movie = self.movie else {
            return
        }
        
        wireframe?.pushToVideoList(allVideos, movie)
    }
    
    func didSeeAllWallpapersClicked(_ allImages: [Image]) {
        guard let movie = self.movie else {
            return
        }
        
        wireframe?.pushToImageList(allImages, movie)
    }
    
    func didSeeAllRelatedMoviesClicked() {
        guard let movie = self.movie else {
            return
        }
        
        wireframe?.pushToRelatedMovies(with: movie)
    }
    
    func didSelectGenre(_ genre: Genre) {
        wireframe?.pushToMovieListByGenre(genre)
    }
    
    func didSeeAllCastClicked() {
        guard let cast = movie?.credits?.cast else {
            return
        }
        let persons = cast.map { (cast) -> PersonItem in
            let personItem = PersonItem(
                                id: cast.id!,
                                name: cast.name ?? "",
                                subtitle: cast.character ?? "",
                                pictureId: cast.profilePath)
            
            return personItem
        }
        
        wireframe?.pushToPersonList(persons, title: "\(String(describing: movie?.title)) \(R.string.localizable.movieDetailsCast())")
    }
    
    func didSeeAllCrewClicked() {
        guard let crew = movie?.credits?.crew else {
            return
        }
        let persons = crew.map { (crewItem) -> PersonItem in
            let personItem = PersonItem(
                        id: crewItem.id!,
                        name: crewItem.name ?? "",
                        subtitle: crewItem.department ?? "",
                        pictureId: crewItem.profilePath)
            
            return personItem
        }
        
        wireframe?.pushToPersonList(persons, title: "\(String(describing: movie?.title)) \(R.string.localizable.movieDetailsCrew())")
    }
    
    func didFavoriteClicked() {
        guard let movie = self.movie else {
            return
        }
        
        movie.isFavorite = self.interactor?.didFavoriteClicked(with: movie) ?? false
        
        if movie.isFavorite && !movie.isWatched {
            movie.isWatched = true
        }
        
        self.view?.setupButtons(movie)
    }
    
    func didWatchedClicked() {
        guard let movie = self.movie else {
            return
        }
        
        movie.isWatched = self.interactor?.didWatchedClicked(with: movie) ?? false
        
        if !movie.isWatched {
            movie.isFavorite = false
        }
        
        self.view?.setupButtons(movie)
    }
    
    func didWantToSeeClicked() {
        guard let movie = self.movie else {
            return
        }
        
        movie.isWantToSee = self.interactor?.didWantToSeeClicked(with: movie) ?? false
        
        self.view?.setupButtons(movie)
    }
}

// MARK: MovieDetailsInteractorOutputInterface

extension MovieDetailsPresenter: MovieDetailsInteractorOutputInterface {
    
    func movieDetailsDidFetch(_ movie: Movie) {
        self.movie?.credits = movie.credits
        self.movie?.keywords = movie.keywords
        self.movie?.runtime = movie.runtime
        self.movie?.videos = movie.videos
        self.movie?.images = movie.images
        self.movie?.homepage = movie.homepage
        self.movie?.productionCompanies = movie.productionCompanies
        self.movie?.productionCountries = movie.productionCountries
        self.movie?.similiarMovies = movie.similiarMovies
        self.movie?.genres = movie.genres
        
        self.movie?.isFavorite = movie.isFavorite
        self.movie?.isWantToSee = movie.isWantToSee
        self.movie?.isWatched = movie.isWatched
        
        self.view?.showMovie(with: movie)
        self.view?.setupButtons(movie)
    }
    
    func movieRankingsDidFetch(_ movie: MovieOMDB) {
        self.movieRankings = movie
        
        self.view?.showMovieRankings(with: movie)
    }
    
    func movieDetailsDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
    
    func movieRankingsDidFetch(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
    
}
