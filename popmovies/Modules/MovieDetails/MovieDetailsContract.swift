//
//  MovieDetailsContract.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import RxSwift

protocol MovieDetailsViewInterface: BaseViewInterface {
    
    var presenter: MovieDetailsPresenterInterface? { get set }
    
    func showMovie(with movie: Movie)
    func showMovieRankings(with movieRankings: MovieOMDB)
}

protocol MovieDetailsPresenterInterface: BasePresenterInterface {
    
    var view: MovieDetailsViewInterface? { get set }
    var interactor: MovieDetailsInteractorInputInterface? { get set }
    var wireframe: MovieDetailsWireframeInterface? { get set }
    
    func fetchMovieDetails()
    
    func didSelectPerson(_ person: Person)
    func didSelectMovie(_ movie: Movie)
    func didSelectLink(url: String)
    func didSelectGenre(_ genre: Genre)
    func didSelectImage(_ image: Image, _ allImages: [Image], indexPath: IndexPath)
    func didSelectVideo(_ video: Video, _ allVideos: [Video])
    func didSeeAllVideosClicked(_ allVideos: [Video])
    func didSeeAllWallpapersClicked(_ allImages: [Image])
    func didSeeAllRelatedMoviesClicked()
}

protocol MovieDetailsInteractorInputInterface: BaseInteractorInterface {
    var output: MovieDetailsInteractorOutputInterface? { get set }
    
    func fetchMovieDetails(movie: Movie)
    func fetchMovieRankings(imdbId: String?)
}

protocol MovieDetailsInteractorOutputInterface {
    
    func movieDetailsDidFetch(_ movie: Movie)
    func movieRankingsDidFetch(_ movie: MovieOMDB)
    
    func movieDetailsDidError(_ error: DefaultError)
    func movieRankingsDidFetch(_ error: DefaultError)
}

protocol MovieDetailsWireframeInterface: BaseWireframeInterface {
    
    func presentExternalLink(from url: String)
    func presentDetails(for person: Person)
    func presentDetails(for movie: Movie)
    func presentImageViewer(for image: Image, _ allImages: [Image], _ movie: Movie, indexPath: IndexPath)
    func presentVideoViewer(for video: Video, _ allVideos: [Video], _ movie: Movie)
    func pushToRelatedMovies(with movie: Movie)
    func pushToMovieListByGenre(_ genre: Genre)
    func pushToVideoList(_ allVideos: [Video], _ movie: Movie)
    func pushToImageList(_ allImages: [Image], _ movie: Movie)
    
    static func buildModule(with movie: Movie?) -> UIViewController
    static func buildModule() -> UIViewController
    

}
