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
        
//        if let controller = self.storyboard!.instantiateViewController(withIdentifier: PersonDetailsIdentifier) as? PersonDetailsController {
//
//            controller.hero.modalAnimationType = .slide(direction: .left)
//            controller.person = person
//
//            self.show(controller, sender: nil)
//        }
    }
    
    func presentDetails(for movie: Movie) {
        let movieDetailsModule = MovieDetailsWireframe.buildModule(with: movie) as! MovieDetailsController
        
        movieDetailsModule.movie = movie
        
        self.viewController?.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(movieDetailsModule, animated: true, completion: nil)
    }
    
    func presentImageViewer(for image: Image, _ allImages: [Image], _ movie: Movie) {
//        if let controller = self.storyboard!.instantiateViewController(withIdentifier: ImageViewerControllerIdentifier) as? ImageViewerController {
//            
//            controller.hero.modalAnimationType = .fade
//            controller.selectedIndex = indexPath
//            controller.image = image
//            controller.allImages = allImages
//            controller.movie = self.movie
//            
//            self.present(controller, animated: true, completion: nil)
//        }
    }
    
    func presentVideoViewer(for video: Video, _ allVideos: [Video],  _ movie: Movie) {
//        if let controller = self.storyboard!.instantiateViewController(withIdentifier: VideoViewerControllerIdentifier) as? VideoViewerController {
//            
//            controller.hero.modalAnimationType = .fade
//            controller.video = video
//            
//            self.present(controller, animated: true, completion: nil)
//        }
    }
    
    func pushToRelatedMovies(with movie: Movie) {
        guard let movieId = movie.id, let navigationController = self.viewController?.navigationController else {
            return
        }
        let url = TMDB.URL.MOVIES.buildSimilarMoviesUrl(movieId: movieId)
        let parameters = TMDB.URL.MOVIES.buildMovieListParameters()
        let title = movie.title ?? "Similar Movies"
        let movieListModule = MovieListWireframe.buildModule(url: url, parameters: parameters, title: title) as! MovieListController
        
        movieListModule.url = url
        movieListModule.parameters = parameters
        movieListModule.title = movie.title
        
        navigationController.hero.navigationAnimationType = .slide(direction: .left)
        navigationController.pushViewController(movieListModule, animated: true)
    }
    
    func pushToMovieListByGenre(_ genre: Genre) {
        guard let id = genre.id else {
            return
        }
        
        let url = TMDB.URL.GENRES.buildMovieListByGenreUrl(id)
        let parameters = TMDB.URL.GENRES.buildMovieListByGenreParameters("BR", 1, "pt_BR")
        let title = genre.name ?? "Movies"
        
        let movieListModule = MovieListWireframe.buildModuleFromUINavigation(url: url, parameters: parameters, title: title)
        
        self.viewController?.navigationController?.pushViewController(movieListModule, animated: true)
    }
    
    func pushToVideoList(_ allVideos: [Video], _ movie: Movie) {
//        guard let controller = self.storyboard!.instantiateViewController(withIdentifier: VideoListControllerIdentifier) as? VideoListController else {
//            return
//        }
//        
//        controller.hero.modalAnimationType = .fade
//        controller.allVideos = allVideos
//        
//        self.present(controller, animated: true, completion: nil)
    }
    
    func pushToImageList(_ allImages: [Image], _ movie: Movie) {
//        guard let controller = self.storyboard!.instantiateViewController(withIdentifier: ImageListControllerIdentifier) as? ImageListController else {
//            return
//        }
//        
//        controller.hero.modalAnimationType = .fade
//        controller.allImages = allImages
//        controller.movie = self.movie
//        
//        self.present(controller, animated: true, completion: nil)
    }
    
}

// MARK: build's Module

extension MovieDetailsWireframe {
    
    static func buildModule(with movie: Movie?) -> UIViewController {
        let movieDetailsModule = MovieDetailsWireframe.buildModule() as! MovieDetailsController
        
        movieDetailsModule.movie = movie
        
        return movieDetailsModule
    }
    
    static func buildModule() -> UIViewController {
        let wireframe = MovieDetailsWireframe()
        let view = R.storyboard.main.movieDetailsController()
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
