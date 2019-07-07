
//
//  RegisterInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: RegisterInteractor: BaseInteractor

class RegisterInteractor: BaseInteractor {
    let movieService: MovieServiceInterface
    
    var output: RegisterInteractorOutputInterface?
    
    init(output: RegisterInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
    }
}

// MARK: RegisterInteractorInputInterface - Output lifecycle Methods

extension RegisterInteractor: RegisterInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}

