//
//  ImageListInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: ImageListInteractor: BaseInteractor

class ImageListInteractor: BaseInteractor {
    let movieService: MovieServiceInterface
    let personService: PersonServiceInterface
    
    var output: ImageListInteractorOutputInterface?
    
    init(output: ImageListInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
        self.personService = PersonService()
    }
}

// MARK: ImageListInteractorInputInterface - Lifecycle methods

extension ImageListInteractor: ImageListInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}
