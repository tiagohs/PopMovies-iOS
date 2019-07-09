
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
        disposibles.dispose()
        
        self.output = nil
    }
    
}

extension LoginInteractor {
    
    func didSignWithGoogle() {
        authManager.signIn(with: .google) { (user, error) in
            if let error = error {
                self.output?.didLoginError(error: error)
                return
            }
            
            guard let user = user else {
                self.output?.didLoginError(error: DefaultError(message: "Error during the login"))
                return
            }
            
            self.output?.didLoginSuccess(user: user)
        }
    }
    
    func didSignWithFacebook() {
        
    }
    
    func didSignWithTwitter() {
        
    }
    
    func didSignWithEmail(_ email: String, _ password: String) {
        
    }
    
    func didSignWithFaceID() {
        
    }
    
}

