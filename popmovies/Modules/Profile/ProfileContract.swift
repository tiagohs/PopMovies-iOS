//
//  ProfileContract.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit


protocol ProfileViewInterface: BaseViewInterface {
    var presenter: ProfilePresenterInterface? { get set }
    
    func setupProfileUI(with user: UserLocal)
    
    func showFavorites(with movies: [Movie])
    func showWatched(with movies: [Movie])
    func updateUserData(_ user: UserLocal)
}

protocol ProfilePresenterInterface: BasePresenterInterface {
    
    var view: ProfileViewInterface? { get set }
    var interactor: ProfileInteractorInputInterface? { get set }
    var wireframe: ProfileWireframeInterface? { get set }
    
    func didSelectMovie(_ movie: Movie)
    func didSeeAllClicked(with movies: [Movie], _ listName: String)
    func didSingUpClicked()
}

protocol ProfileInteractorInputInterface: BaseInteractorInterface {
    var output: ProfileInteractorOutputInterface? { get set }
    
    func didSingUpClicked()
    
    func fetchWatchedMovies()
    func fetchFavoriteMovies()
}

protocol ProfileInteractorOutputInterface {
    
    func didSignOutFinished()
    func didSignOutError(_ error: DefaultError)
    
    func didWatchedMoviesFetch(_ movies: [Movie])
    func didFavoriteMoviesFetch(_ movies: [Movie])
    
    func updateProfileDetails(_ totalMovies: Int, totalDuration: (Int, Int, Int))
}

protocol ProfileWireframeInterface: BaseWireframeInterface {
    
    func presentDetails(for movie: Movie)
    func pushToMovieList(_ movies: [Movie], title: String)
    func presentWelcomeScreen()
    
    static func buildModule() -> UIViewController
}
