
//
//  CalendarInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 06/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: CalendarInteractor: BaseInteractor

class CalendarInteractor: BaseInteractor {
    let movieService: MovieServiceInterface
    
    var output: CalendarInteractorOutputInterface?
    
    init(output: CalendarInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
    }
}

// MARK: CalendarInteractorInputInterface - Output lifecycle Methods

extension CalendarInteractor: CalendarInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}

