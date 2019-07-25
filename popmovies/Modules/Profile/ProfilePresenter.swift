//
//  ProfilePresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: ProfilePresenter

class ProfilePresenter {
    
    var view: ProfileViewInterface?
    var interactor: ProfileInteractorInputInterface?
    var wireframe: ProfileWireframeInterface?
    
    var watchedMovies: [Movie] = []
    var favoriteMovies: [Movie] = []
    var user: UserLocal?
    
    init(view: ProfileViewInterface?) {
        self.view = view
    }
    
}

// MARK: ProfilePresenterInterface

extension ProfilePresenter: ProfilePresenterInterface {
    
    func viewDidLoad() {
        self.user = ProfileManager.shared.getCurrentUser()
        
        self.view?.setupUI()
        self.view?.setupProfileUI(with: user!) 
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.view?.hideNavigationBar(animated)
        
        self.interactor?.fetchWatchedMovies()
        self.interactor?.fetchFavoriteMovies()
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.view?.showNavigationBar(animated)
    }
    
}

// MARK: ProfilePresenterInterface - User Click methods

extension ProfilePresenter {
    
    func didSingUpClicked() {
        view?.showActivityIndicator()
        
        interactor?.didSingUpClicked()
    }
    
    func didSelectMovie(_ movie: Movie) {
        self.wireframe?.presentDetails(for: movie)
    }
    
    func didSeeAllClicked(with movies: [Movie], _ listName: String) {
        guard let userLocal = self.user, let name = userLocal.name else {
            return
        }
        self.wireframe?.pushToMovieList(movies, title: "\(name) \(listName)")
    }
}

// MARK: ProfileInteractorOutputInterface

extension ProfilePresenter: ProfileInteractorOutputInterface {
    
    func didSignOutFinished() {
        self.view?.hideActivityIndicator()
        
        wireframe?.presentWelcomeScreen()
    }
    
    func didSignOutError(_ error: DefaultError) {
        self.view?.hideActivityIndicator()
        
        self.view?.onError(message: error.message)
    }
}

extension ProfilePresenter {
    
    func didWatchedMoviesFetch(_ movies: [Movie]) {
        self.watchedMovies = movies
        
        self.view?.showWatched(with: self.watchedMovies)
    }
    
    func didFavoriteMoviesFetch(_ movies: [Movie]) {
        self.favoriteMovies = movies
        
        self.view?.showFavorites(with: self.favoriteMovies)
    }
    
    func updateProfileDetails(_ totalMovies: Int, totalDuration: (Int, Int, Int)) {
        guard let user = self.user else {
            return
        }
        
        user.totalMovies = totalMovies
        user.totalDuration = totalDuration
        
        self.view?.updateUserData(user)
    }
    
}
