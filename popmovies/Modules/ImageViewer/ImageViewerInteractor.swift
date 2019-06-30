//
//  ImageViewerInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: ImageViewerInteractor: BaseInteractor

class ImageViewerInteractor: BaseInteractor {
    
    var output: ImageViewerInteractorOutputInterface?
    
    init(output: ImageViewerInteractorOutputInterface?) {
        self.output = output
    }
}

// MARK: ImageViewerInteractor: ImageViewerInteractorInputInterface

extension ImageViewerInteractor: ImageViewerInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}
