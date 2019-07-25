
//
//  LoginInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: LoginInteractor: BaseInteractor

class LoginInteractor: BaseInteractor {
    let movieService: MovieServiceInterface
    let authManager: AuthManager!
    
    var output: LoginInteractorOutputInterface?
    
    init(output: LoginInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
        self.authManager = AuthManager.shared
    }
}

// MARK: LoginInteractorInputInterface - Output lifecycle Methods

extension LoginInteractor: LoginInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
    }
    
}

// MARK: LoginInteractorInputInterface - Login Methods

extension LoginInteractor {
    
    func didSignWithGoogle() {
        authManager.signIn(with: .google) { (user, error) in
            self.onLogin(user, error)
        }
    }
    
    func didSignWithFacebook(with viewController: UIViewController) {
        authManager.viewController = viewController
        
        authManager.signIn(with: .facebook) { (user, error) in
            self.onLogin(user, error)
        }
    }
    
    func didSignWithTwitter(with viewController: UIViewController) {
        authManager.viewController = viewController

        authManager.signIn(with: .twitter) { (user, error) in
            self.onLogin(user, error)
        }
    }
    
    func didSignWithEmail(_ email: String, _ password: String) {
        authManager.signIn(with: email, password) { (user, error) in
            self.onLogin(user, error)
        }
    }
    
    func didSignWithFaceID() {
        
    }
    
    private func onLogin(_ user: UserLocal?, _ error: DefaultError?) {
        if let error = error {
            self.output?.didLoginError(error: error)
            return
        }
        
        guard let user = user else {
            self.output?.didLoginError(error: DefaultError(message: R.string.localizable.loginUnknownError()))
            return
        }
        
        self.output?.didLoginSuccess(user: user)
    }
}

