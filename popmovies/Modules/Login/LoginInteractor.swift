
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
    
    var output: LoginInteractorOutputInterface?
    
    init(output: LoginInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
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

