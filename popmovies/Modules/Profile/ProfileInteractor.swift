//
//  ProfileInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: ProfileInteractor: BaseInteractor 

class ProfileInteractor: BaseInteractor {
    
    var output: ProfileInteractorOutputInterface?
    
    init(output: ProfileInteractorOutputInterface?) {
        self.output = output
    }
}

// MARK: ProfileInteractorInputInterface - Output Lifecycle Methods

extension ProfileInteractor: ProfileInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}
