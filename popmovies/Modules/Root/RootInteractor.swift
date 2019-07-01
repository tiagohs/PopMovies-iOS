//
//  RootInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: RootInteractor: BaseInteractor

class RootInteractor: BaseInteractor {
    
    var output: RootInteractorOutputInterface?
    
    init(output: RootInteractorOutputInterface?) {
        self.output = output
    }
}

// MARK: RootInteractorInputInterface - Output Lifecycle Methods

extension RootInteractor: RootInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}
