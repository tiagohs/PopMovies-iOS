
//
//  WelcomeInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: WelcomeInteractor: BaseInteractor

class WelcomeInteractor: BaseInteractor {
    let movieService: MovieServiceInterface
    
    var output: WelcomeInteractorOutputInterface?
    
    init(output: WelcomeInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
    }
}

// MARK: WelcomeInteractorInputInterface - Output lifecycle Methods

extension WelcomeInteractor: WelcomeInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}

