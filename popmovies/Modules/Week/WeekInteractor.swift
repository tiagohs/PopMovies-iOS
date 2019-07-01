//
//  WeekInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: WeekInteractor: BaseInteractor

class WeekInteractor: BaseInteractor {
    
    var output: WeekInteractorOutputInterface?
    
    init(output: WeekInteractorOutputInterface?) {
        self.output = output
    }
}

// MARK: WeekInteractorInputInterface - Output Lifecycle Methods

extension WeekInteractor: WeekInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}
