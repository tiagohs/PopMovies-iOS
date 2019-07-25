//
//  MovieDetailsWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 29/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: MovieDetailsWireframe: MovieDetailsWireframeInterface

class MovieDetailsWireframe: MovieDetailsWireframeInterface {
    
    weak var viewController: UIViewController?
    
    func presentExternalLink(from url: String) {
        guard let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let encondedURL = URL(string: encoded) else {
            return
        }
        
        UIApplication.shared.open(encondedURL)
    }
    
    func presentDetails(for person: Person) {
        let personDetailsModule = PersonDetailsWireframe.buildModule(with: person)
        
        self.viewController?.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(personDetailsModule, animated: true, completion: nil)
    }
    
    func presentDetails(for movie: Movie) {
        let movieDetailsModule = MovieDetailsWireframe.buildModule(with: movie)
        
        self.viewController?.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(movieDetailsModule, animated: true, completion: nil)
    }
    
    func presentImageViewer(for image: Image, _ allImages: [Image], _ movie: Movie, indexPath: IndexPath) {
        let imageViewerModule = ImageViewerWireframe.buildModule(image, allImages: allImages, indexPath, movie, nil)
        
        imageViewerModule.hero.modalAnimationType = .fade
        
        self.viewController?.present(imageViewerModule, animated: true, completion: nil)
    }
    
    func presentVideoViewer(for video: Video, _ allVideos: [Video],  _ movie: Movie) {
        let videoModule = VideoViewerWireframe.buildModule(video)
        
        videoModule.hero.modalAnimationType = .fade
        self.viewController?.present(videoModule, animated: true, completion: nil)
    }
    
    func pushToRelatedMovies(with movie: Movie) {
        guard let movieId = movie.id else {
            return
        }
        let url = TMDB.URL.MOVIES.buildSimilarMoviesUrl(movieId: movieId)
        let parameters = TMDB.URL.MOVIES.buildMovieListParameters()
        let title = movie.title ?? R.string.localizable.movieDetailsSimilarMovies()
        let movieListModule = MovieListWireframe.buildModuleFromUINavigation(url: url, parameters: parameters, title: title)
        
        movieListModule.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(movieListModule, animated: true, completion: nil)
    }
    
    func pushToMovieListByGenre(_ genre: Genre) {
        guard let id = genre.id else {
            return
        }
        
        let url = TMDB.URL.GENRES.buildMovieListByGenreUrl(id)
        let parameters = TMDB.URL.GENRES.buildMovieListByGenreParameters("BR", 1, "pt_BR")
        let title = genre.name ?? R.string.localizable.movieListTitle()
        
        let movieListModule = MovieListWireframe.buildModuleFromUINavigation(url: url, parameters: parameters, title: title)
        
        movieListModule.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(movieListModule, animated: true, completion: nil)
    }
    
    func pushToVideoList(_ allVideos: [Video], _ movie: Movie) {
        let videoListModule = VideoListWireframe.buildModule(allVideos, movie, nil)
        
        videoListModule.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(videoListModule, animated: true, completion: nil)
    }
    
    func pushToImageList(_ allImages: [Image], _ movie: Movie) {
        let imageListModule = ImageListWireframe.buildModule(allImages, person: nil, movie)
        
        imageListModule.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(imageListModule, animated: true, completion: nil)
    }
    
    func pushToPersonList(_ allPersons: [PersonItem], title: String) {
        let module = PersonListWireframe.buildModuleFromUINavigation(with: allPersons, title: title)
        
        self.viewController?.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(module, animated: true, completion: nil)
    }
    
}

// MARK: build's Module

extension MovieDetailsWireframe {
    
    static func buildModule(with movie: Movie?) -> UIViewController {
        let movieDetailsModule = MovieDetailsWireframe.buildModule() as! MovieDetailsController
        let presenter = movieDetailsModule.presenter as! MovieDetailsPresenter
        
        movieDetailsModule.movie = movie
        presenter.movie = movie
        
        return movieDetailsModule
    }
    
    static func buildModule() -> UIViewController {
        let wireframe = MovieDetailsWireframe()
        let view = R.storyboard.movieDetails.movieDetailsController()
        let presenter = MovieDetailsPresenter(view: view)
        let interactor = MovieDetailsInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }
    
    
}
