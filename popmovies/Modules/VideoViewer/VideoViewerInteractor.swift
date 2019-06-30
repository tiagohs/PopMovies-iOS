//
//  VideoViewerInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: VideoViewerInteractor: BaseInteractor

class VideoViewerInteractor: BaseInteractor {
    
    var output: VideoViewerInteractorOutputInterface?
    
    init(output: VideoViewerInteractorOutputInterface?) {
        self.output = output
    }
}

// MARK: VideoViewerInteractorInputInterface - Lifecycle methods

extension VideoViewerInteractor: VideoViewerInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
}
