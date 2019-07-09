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
    
    init(view: ProfileViewInterface?) {
        self.view = view
    }
    
}

// MARK: ProfilePresenterInterface

extension ProfilePresenter: ProfilePresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.view?.hideNavigationBar(animated)
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.view?.showNavigationBar(animated)
    }
    
}

extension ProfilePresenter {
    
    func didSingUpClicked() {
        view?.showActivityIndicator()
        
        interactor?.didSingUpClicked()
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
