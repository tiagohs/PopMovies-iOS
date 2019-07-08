
//
//  PersonListInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: PersonListInteractor: BaseInteractor

class PersonListInteractor: BaseInteractor {
    var output: PersonListInteractorOutputInterface?
    
    init(output: PersonListInteractorOutputInterface?) {
        self.output = output
    }
}

// MARK: PersonListInteractorInputInterface - Output lifecycle Methods

extension PersonListInteractor: PersonListInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}

