
//
//  LoginPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: LoginPresenter

class LoginPresenter {
    
    var view: LoginViewInterface?
    var interactor: LoginInteractorInputInterface?
    var wireframe: LoginWireframeInterface?
    
    init(view: LoginViewInterface?) {
        self.view = view
    }
    
}

// MARK: HomePresenterInterface - Lifecycle methods

extension LoginPresenter: LoginPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        self.view?.setupGoogleAuthUI()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

// MARK: HomePresenterInterface - User click methods

extension LoginPresenter {
    
    func didSignUpClicked() {
        wireframe?.presentSignUp()
    }
    
    func didSignWithEmailClicked(_ email: String, _ password: String) {
        view?.showActivityIndicator()
        
        self.interactor?.didSignWithEmail(email, password)
    }
    
    func didSignWithFaceIdClicked() {
        
    }
    
    func didSignWithFacebookClicked(with viewController: UIViewController) {
        view?.showActivityIndicator()
        
        self.interactor?.didSignWithFacebook(with: viewController)
    }
    
    func didSignWithTwitterClicked(with viewController: UIViewController) {
        view?.showActivityIndicator()
        
        self.interactor?.didSignWithTwitter(with: viewController)
    }
    
    func didSignWithGoogleClicked() {
        view?.showActivityIndicator()
        
        interactor?.didSignWithGoogle()
    }
    
}

// MARK: LoginInteractorOutputInterface

extension LoginPresenter: LoginInteractorOutputInterface {
    
    func didLoginSuccess(user: UserLocal) {
        view?.hideActivityIndicator()
        
        wireframe?.presentRootScreen()
    }
    
    func didLoginError(error: DefaultError) {
        view?.hideActivityIndicator()
        
        self.view?.onError(message: error.message)
    }
}
